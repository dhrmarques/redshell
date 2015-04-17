class TaskTypesController < ApplicationController
  before_action :set_task_type, only: [:show, :edit, :update, :destroy]

  # GET /task_types
  # GET /task_types.json
  def index
    @task_types = TaskType.where(active: true).includes(:task_domain)
  end

  # GET /task_types/1
  # GET /task_types/1.json
  def show
  end

  # GET /task_types/new
  def new
    @place_types = PlaceType.all
    @task_type = TaskType.new
    @task_domains = TaskDomain.where(active: true)
  end

  # GET /task_types/1/edit
  def edit
    @task_domains = TaskDomain.where(active: true)
  end

  # POST /task_types
  # POST /task_types.json
  def create
    @task_type = TaskType.new(task_type_params)
    @task_type.place_types = PlaceType.where(:id => params["place_types"])
    respond_to do |format|
      if @task_type.save
        format.html { redirect_to @task_type, notice: 'Task type was successfully created.' }
        format.json { render :show, status: :created, location: @task_type }
      else
        format.html { render :new }
        format.json { render json: @task_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /task_types/1
  # PATCH/PUT /task_types/1.json
  def update
    respond_to do |format|
      if @task_type.update(task_type_params)
        format.html { redirect_to @task_type, notice: 'Task type was successfully updated.' }
        format.json { render :show, status: :ok, location: @task_type }
      else
        format.html { render :edit }
        format.json { render json: @task_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /task_types/1
  # DELETE /task_types/1.json
  def destroy
    @task_type.active = false

    respond_to do |format|
      if @task_type.save
        format.html { redirect_to task_types_url, notice: 'Task type was successfully deactivated.' }
        format.json { head :no_content }
      else
        format.html { render :index }
        format.json { render json: @task_type.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task_type
      @task_type = TaskType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_type_params
      params.require(:task_type).permit(:title, :week_days, :each_n_weeks, :description, :task_domain_id, :ignore_if_vacant, :after_in_minutes, :before_in_minutes)
    end
end
