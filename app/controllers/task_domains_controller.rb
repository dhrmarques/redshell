class TaskDomainsController < ApplicationController
  before_action :set_task_domain, only: [:show, :edit, :update, :destroy]

  # GET /task_domains
  # GET /task_domains.json
  def index
    @task_domains = TaskDomain.all
  end

  # GET /task_domains/1
  # GET /task_domains/1.json
  def show
  end

  # GET /task_domains/new
  def new
    @task_domain = TaskDomain.new
  end

  # GET /task_domains/1/edit
  def edit
  end

  # POST /task_domains
  # POST /task_domains.json
  def create
    @task_domain = TaskDomain.new(task_domain_params)

    respond_to do |format|
      if @task_domain.save
        format.html { redirect_to @task_domain, notice: 'Task domain was successfully created.' }
        format.json { render :show, status: :created, location: @task_domain }
      else
        format.html { render :new }
        format.json { render json: @task_domain.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /task_domains/1
  # PATCH/PUT /task_domains/1.json
  def update
    respond_to do |format|
      if @task_domain.update(task_domain_params)
        format.html { redirect_to @task_domain, notice: 'Task domain was successfully updated.' }
        format.json { render :show, status: :ok, location: @task_domain }
      else
        format.html { render :edit }
        format.json { render json: @task_domain.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /task_domains/1
  # DELETE /task_domains/1.json
  def destroy
    @task_domain.destroy
    respond_to do |format|
      format.html { redirect_to task_domains_url, notice: 'Task domain was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task_domain
      @task_domain = TaskDomain.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_domain_params
      params.require(:task_domain).permit(:title, :description)
    end
end
