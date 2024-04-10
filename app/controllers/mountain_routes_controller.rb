class MountainRoutesController < ApplicationController
  before_action :set_mountain_route, only: %i[ show edit update destroy ]

  # GET /mountain_routes or /mountain_routes.json
  def index
    @mountain_routes = MountainRoute.all
  end

  # GET /mountain_routes/1 or /mountain_routes/1.json
  def show
  end

  # GET /mountain_routes/new
  def new
    @mountain_route = MountainRoute.new
  end

  # GET /mountain_routes/1/edit
  def edit
  end

  # POST /mountain_routes or /mountain_routes.json
  def create
    @mountain_route = current_user.mountain_routes.new(mountain_route_params)

    respond_to do |format|
      if @mountain_route.save
        format.html { redirect_to mountain_route_url(@mountain_route), notice: "Mountain route was successfully created." }
        format.json { render :show, status: :created, location: @mountain_route }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @mountain_route.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mountain_routes/1 or /mountain_routes/1.json
  def update
    respond_to do |format|
      if @mountain_route.update(mountain_route_params)
        format.html { redirect_to mountain_route_url(@mountain_route), notice: "Mountain route was successfully updated." }
        format.json { render :show, status: :ok, location: @mountain_route }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @mountain_route.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mountain_routes/1 or /mountain_routes/1.json
  def destroy
    @mountain_route.destroy!

    respond_to do |format|
      format.html { redirect_to mountain_routes_url, notice: "Mountain route was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mountain_route
      @mountain_route = MountainRoute.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def mountain_route_params
      params.require(:mountain_route).permit(:activity_date, :area, :custom_difficulty, :equipped, :french_difficulty, :length, :multipitch, :multipitch_difficulty, :multipitch_lead, :multipitch_number, :multipitch_style, :name, :partner, :style, :description)
    end
end
