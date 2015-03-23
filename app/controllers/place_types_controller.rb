class PlaceTypesController < ApplicationController
  before_action :set_place_type, only: [:show, :edit, :update, :destroy]

  # GET /place_types
  # GET /place_types.json
  def index
    @place_types = PlaceType.all
  end

  # GET /place_types/1
  # GET /place_types/1.json
  def show
  end

  # GET /place_types/new
  def new
    @place_type = PlaceType.new
  end

  # GET /place_types/1/edit
  def edit
  end

  # POST /place_types
  # POST /place_types.json
  def create
    @place_type = PlaceType.new(place_type_params)

    respond_to do |format|
      if @place_type.save
        format.html { redirect_to @place_type, notice: 'Place type was successfully created.' }
        format.json { render :show, status: :created, location: @place_type }
      else
        format.html { render :new }
        format.json { render json: @place_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /place_types/1
  # PATCH/PUT /place_types/1.json
  def update
    respond_to do |format|
      if @place_type.update(place_type_params)
        format.html { redirect_to @place_type, notice: 'Place type was successfully updated.' }
        format.json { render :show, status: :ok, location: @place_type }
      else
        format.html { render :edit }
        format.json { render json: @place_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /place_types/1
  # DELETE /place_types/1.json
  def destroy
    @place_type.active = false

    respond_to do |format|
      if @place_type.save
        format.html { redirect_to place_types_url, notice: 'Place type was successfully deactivated.' }
        format.json { head :no_content }
      else
        format.html { render :index }
        format.json { render json: @place_type.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_place_type
      @place_type = PlaceType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def place_type_params
      params.require(:place_type).permit(:title, :description, :restricted, :common)
    end
end
