class ServicesController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }

  def index
    @services = Service.all.includes(:place, :task_type)
  end

  def create
    services = params["services"]

    services.each do |service|
      respond_to do |format|
        if Service.new(service_params(service)).save
          format.json { render json: service, status: :created }
        else
          format.json { render json: service.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def destroy
    @service = Service.find(params[:id])
    respond_to do |format|
      if @service.destroy
        format.html { redirect_to services_url, notice: 'service was successfully destroyed.' }
      else
        format.html { redirect_to services_url, notice: 'service was unsuccessfully destroyed.' }
      end
    end
  end

  def create_task
    redirect_to :controller => :tasks, :action => :new, :sid => params[:id]
  end

  def list
    task_types = TaskType.all.where(:each_n_weeks => nil).select(:id, :title, :description)
    places = Place.all.where(:active => true).select(:id, :code, :place_type_id)
    response_json = {"places" => places, "services" => task_types}
    respond_to do |format|
      format.json { render json: response_json, status: 200 }
    end
  end

  private
  def service_params(service)
    service.permit(:after, :before, :task_type_id, :place_id)
  end

end
