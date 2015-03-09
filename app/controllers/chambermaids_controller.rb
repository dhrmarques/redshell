class ChambermaidsController < ApplicationController
  before_action :set_chambermaid, only: [:show, :edit, :update, :destroy]

  # GET /chambermaids
  # GET /chambermaids.json
  def index
    @chambermaids = Chambermaid.all
  end

  # GET /chambermaids/1
  # GET /chambermaids/1.json
  def show
  end

  # GET /chambermaids/new
  def new
    @chambermaid = Chambermaid.new
  end

  # GET /chambermaids/1/edit
  def edit
  end

  # POST /chambermaids
  # POST /chambermaids.json
  def create
    @chambermaid = Chambermaid.new(chambermaid_params)

    respond_to do |format|
      if @chambermaid.save
        format.html { redirect_to @chambermaid, notice: 'Chambermaid was successfully created.' }
        format.json { render :show, status: :created, location: @chambermaid }
      else
        format.html { render :new }
        format.json { render json: @chambermaid.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /chambermaids/1
  # PATCH/PUT /chambermaids/1.json
  def update
    respond_to do |format|
      if @chambermaid.update(chambermaid_params)
        format.html { redirect_to @chambermaid, notice: 'Chambermaid was successfully updated.' }
        format.json { render :show, status: :ok, location: @chambermaid }
      else
        format.html { render :edit }
        format.json { render json: @chambermaid.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chambermaids/1
  # DELETE /chambermaids/1.json
  def destroy
    @chambermaid.destroy
    respond_to do |format|
      format.html { redirect_to chambermaids_url, notice: 'Chambermaid was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chambermaid
      @chambermaid = Chambermaid.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def chambermaid_params
      params.require(:chambermaid).permit(:login, :passcode, :name, :surname)
    end
end
