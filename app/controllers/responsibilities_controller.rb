class ResponsibilitiesController < ApplicationController
  before_action :set_responsibility, only: [:show, :edit, :update, :destroy]

  # GET /responsibilities
  # GET /responsibilities.json
  def index
    @responsibilities = Responsibility.where(active: true)
  end

  # GET /responsibilities/1
  # GET /responsibilities/1.json
  def show
  end

  # GET /responsibilities/new
  def new
    @responsibility = Responsibility.new
    @task_domains = TaskDomain.where(active: true)
    @employee_types = EmployeeType.where(active: true)
  end

  # GET /responsibilities/1/edit
  def edit
    @task_domains = TaskDomain.where(active: true)
    @employee_types = EmployeeType.where(active: true)
  end

  # POST /responsibilities
  # POST /responsibilities.json
  def create
    @responsibility = Responsibility.new(responsibility_params)

    respond_to do |format|
      if @responsibility.save
        format.html { redirect_to @responsibility, notice: 'Responsibility was successfully created.' }
        format.json { render :show, status: :created, location: @responsibility }
      else
        format.html { render :new }
        format.json { render json: @responsibility.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /responsibilities/1
  # PATCH/PUT /responsibilities/1.json
  def update
    respond_to do |format|
      if @responsibility.update(responsibility_params)
        format.html { redirect_to @responsibility, notice: 'Responsibility was successfully updated.' }
        format.json { render :show, status: :ok, location: @responsibility }
      else
        format.html { render :edit }
        format.json { render json: @responsibility.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /responsibilities/1
  # DELETE /responsibilities/1.json
  def destroy
    @responsibility.active = false

    respond_to do |format|
      if @responsibility.save
        format.html { redirect_to responsibilities_url, notice: 'Responsibility was successfully deactivated.' }
        format.json { head :no_content }
      else
        format.html { render :index }
        format.json { render json: @responsibility.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_responsibility
      @responsibility = Responsibility.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def responsibility_params
      params.require(:responsibility).permit(:task_domain_id, :employee_type_id)
    end
end
