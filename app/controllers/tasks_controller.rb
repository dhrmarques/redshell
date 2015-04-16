require "uri"
# require "resolv-replace.rb"

class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy, :checkin, :checkout, :status, :reset]
  before_action :set_tasks, only: [:index, :destroy]
  before_action :set_general_tools, only: [:new, :edit, :update, :create]

  # GET /tasks
  # GET /tasks.json
  def index
    @products = list_products
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Service.exists?(params[:sid]).blank? ? Task.new : Task.new(Service.find(params[:sid]).attributes)
    @service = Service.find(params[:sid]) unless Service.exists?(params[:sid]).blank?
    load_needed_resources
  end

  # GET /tasks/1/edit
  def edit
    load_needed_resources
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)
    consume_products(task_params["tool_ids"])
    
    respond_to do |format|
      if @task.save
        unless params["extra_field"]["service_id"].blank?
          Service.find(params["extra_field"]["service_id"]).delete
        end
        if params[:sid]
          Service.delete(params[:sid])
        end
        format.html { redirect_to @task, notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update    
    load_needed_resources
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.active = false

    respond_to do |format|
      if @task.save!
        format.html { redirect_to tasks_url, notice: 'Task was successfully deactivated.' }
        format.json { head :no_content }
      else
        format.html { render :index }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /tasks/pick_domain
  def pick_domain
    tdid = params[:domain_id]
    @task_types = TaskType.where(task_domain_id: tdid)
    employee_type_ids = Responsibility.where(task_domain_id: tdid).pluck(:employee_type_id).uniq
    @employees = Employee.where(employee_type_id: employee_type_ids).includes(:employee_type).order(:employee_type_id)

    render json: {
      task_types: @task_types.map { |tt| [tt.id, tt.title, tt.description] },
      task_types_prompt: "Escolha um #{TaskType.label.downcase}",
      employees: @employees.map { |emp| [emp.id, "(#{emp.employee_type.title}) - #{emp.fullname}"] },
      employees_prompt: "Escolha um #{Employee.label.downcase}"
    } if request.xhr?
  end

  # GET /tasks/pick_type
  def pick_type
    ttid = params[:type_id]
    place_type_ids = TaskType.find(ttid).place_types.pluck(:id).uniq
    @places = Place.where(place_type_id: place_type_ids).includes(:place_type).order(:place_type_id)

    render json: {
      places: @places.map { |pl| [pl.id, "(#{pl.place_type.title}) - #{pl.code}"] },
      places_prompt: "Escolha um #{Place.label.downcase}"
    } if request.xhr?
  end

  # GET /tasks/todo
  def todo
    @todos = []
    spotodos, regtodos = [], []
    tasks = Task.
        where(active: true, employee_id: current_employee.id, checkin_finish: nil).
        includes(:place, :task_type).
        order(checkin_start: :desc, before: :asc)
    
    tasks.each do |tsk|
      todo = {task: tsk}.merge(tsk.urgency_params)
      if todo[:spotlight]
        spotodos << todo
      else
        regtodos << todo
      end
    end

    @todos = spotodos + regtodos
    render 'todo', layout: 'mobile'
  end

  # GET /tasks/1/status
  def status
    @options = @task.urgency_params
    render :status, layout: 'mobile'
  end

  # GET /tasks/overview
  def overview
    #
  end

  def checkin
    @task.checkin_start = Time.now
    respond_to do |format|
      if @task.save!
        format.html { redirect_to status_task_path(@task), notice: 'Check-in done for task.' }
        format.json { head :no_content }
      else
        format.html { render :todo, notice: 'Check-in failed for task.' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def checkout
    @task.checkin_finish = Time.now
    respond_to do |format|
      if @task.save!
        format.html { redirect_to todo_tasks_path, notice: 'Check-out done for task.' }
        format.json { head :no_content }
      else
        format.html { render :todo, notice: 'Check-out failed for task.' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def reset
    @task.checkin_start = nil
    @task.checkin_finish = nil
    respond_to do |format|
      if @task.save!
        format.html { redirect_to tasks_url, notice: 'Task reset successfully.' }
        format.json { head :no_content }
      else
        format.html { render :index }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    def set_tasks
      if current_employee.is_admin?
        @tasks = Task.where(active: true).includes(:employee, :task_type, :place, :tools)
      elsif current_employee
        @tasks = current_employee.tasks.where(active: true).includes(:employee, :task_type, :place, :tools)
        @tasks_for_checkin = Task.where(active: true).where("after >= ? and checkin_start IS NULL", Time.now).includes(:employee, :task_type, :place, :tools)
        @tasks_for_checkout = Task.where(active: true).where("checkin_start IS NOT NULL and checkin_finish IS NULL").includes(:employee, :task_type, :place, :tools)
      end
    end

    def set_general_tools
      if @task
        task_tools_ids = @task.tools.map {|t| t.id}
      elsif params[:task]
        task_tools_ids = params[:task][:tool_ids]
      else
        task_tools_ids = []
      end
      @general_tools = Tool.where(active: true).where.not(id: task_tools_ids)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:after, :before, :checkin_start, :checkin_finish, :details, :employee_id, :place_id, :task_type_id, tool_ids: [])
    end

    def load_needed_resources
      @employees = Employee.where(active: true)
      @task_domains = TaskDomain.where(active: true)
      @task_types = TaskType.where(active: true)
      @place_types = PlaceType.where(active: true)
      @places = Place.where(active: true)
    end

    #devolve se deu certo ou nao
    def consume_products(product_ids)
      # uri = URI.parse("http://www.google.com")
      # response = Net::HTTP.get_response(uri)
      # Net::HTTP.get_print(uri)
      
      product_ids.each do |product_id|
        uri = URI('http://' + STOCK_URL + '/' + STOCK_LIST_PATH)
        # uri = URI("http://echo.jsontest.com/")
        request = Net::HTTP::Put.new(uri)
        request.set_form_data({"ID" => product_id.to_s, "Quantity" => "1"})
        # Headers
        request['Content-Type'] = 'application/json'
        request['Cache-Control'] = 'no-cache'
        
        begin
          response = Net::HTTP.delay.start(uri.hostname, uri.port){|http|
            http.request(request)
          }

          product_list = response.to_json

          #OK e variaveis
          if response.kind_of? Net::HTTPSuccess
            return true
          else
            p "Request: " + request.body.to_s
            p "Failed with: " + response.code
            false
          end
        rescue SystemCallError, StandardError
          p "An error occured: " + $!.inspect
          false
        end
      end
    end

    def list_products
      uri = URI('http://' + STOCK_URL + '/' + STOCK_LIST_PATH)
      # uri = URI("http://echo.jsontest.com/")
      request = Net::HTTP::Get.new(uri)
      # Headers
      request['Content-Type'] = 'application/json'
      request['Cache-Control'] = 'no-cache'
      
      begin
        response = Net::HTTP.start(uri.hostname, uri.port){|http|
          http.request(request)
        }

        product_list = response.body.to_json

        #OK e variaveis
        unless response.code.starts_with?("2")
          product_list = [].to_json
        end

        p "product_list"
        p product_list
        product_list
      rescue SystemCallError, StandardError
        p "An error occured: " + $!.inspect
      end
    end
end
