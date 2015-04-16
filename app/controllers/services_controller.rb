class ServicesController < ApplicationController
  # GET /responsibilities
  # GET /responsibilities.json
  def index
    @responsibilities = Responsibility.all
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
    @responsibility.destroy

    respond_to do |format|
      format.html { redirect_to responsibilities_url, notice: 'Responsibility was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

end
