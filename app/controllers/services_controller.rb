class ServicesController < ApplicationController

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

  def show
    
  end

  def list
    task_types = TaskType.all
    places = Place.all
    response_json = {"places" => places, "services" => task_types}
    respond_to do |format|
      format.json { render json: response_json, status: :OK }
    end
  end

  private
  def service_params(service)
    service.permit(:after, :before, :task_type_id, :place_id)
  end

end
