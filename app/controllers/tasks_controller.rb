class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.where(active: true).includes(:employee, :task_type, :place)
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
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
    load_needed_resources
    
    respond_to do |format|
      if @task.save
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
      if @task.save
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:after, :before, :checkin_start, :checkin_finish, :details, :employee_id, :place_id, :task_type_id)
    end

    def load_needed_resources
      @employees = Employee.where(active: true)
      @task_domains = TaskDomain.where(active: true)
      @task_types = TaskType.where(active: true)
      @place_types = PlaceType.where(active: true)
      @places = Place.where(active: true)
    end
end
