class ServicesController < ApplicationController

  def index
    @services = Service.all
  end

  def create
    service = Service.new(service_params)

    respond_to do |format|
      if service.save
        format.json { render json: service, status: :created }
      else
        format.json { render json: service.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @service.destroy
        format.html { redirect_to services_url, notice: 'service was successfully destroyed.' }
      else
        format.html { redirect_to services_url, notice: 'service was unsuccessfully destroyed.' }
      end
    end
  end

  private
  def service_params
    params.require(:service).permit(:after, :before, :task_type_id, :place_id)
  end

end
