class MountainRoutesController < ApplicationController
  before_action :set_mountain_route, only: %i[ show edit update destroy ]

  def index
    mountain_routes = MountainRoute.arel_table
    query = mountain_routes[:id].not_eq(nil)
    query = query.and(mountain_routes[:activity_date].gteq( Date.new(params.dig(:year).to_i, 1, 1).beginning_of_year)) if params.dig(:year).present?
    query = query.and(mountain_routes[:sport_type].eq(params.dig(:sport_type))) if params.dig(:sport_type).present?

    @mountain_routes = MountainRoute.where(query).search(params.dig(:search)).order(activity_date: :desc) if params.dig(:search).present?
    @mountain_routes = MountainRoute.where(query).order(activity_date: :desc) if params.dig(:search).blank?

    @pagy, @mountain_routes = pagy(@mountain_routes)
  end

  def show
    authorize @mountain_route
  end

  def new
    @mountain_route = MountainRoute.new

    authorize @mountain_route
  end

  def edit
    authorize @mountain_route
  end

  def create
    @mountain_route = current_user.mountain_routes.new(mountain_route_params)

    authorize @mountain_route

    respond_to do |format|
      if @mountain_route.save
        format.html { redirect_to mountain_route_url(@mountain_route), notice: t('mountain_routes.create.success') }
        format.json { render :show, status: :created, location: @mountain_route }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @mountain_route.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @mountain_route

    respond_to do |format|
      if @mountain_route.update(mountain_route_params)
        format.html { redirect_to mountain_route_url(@mountain_route), notice: t("mountain_routes.update.success") }
        format.json { render :show, status: :ok, location: @mountain_route }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @mountain_route.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @mountain_route

    @mountain_route.destroy!

    respond_to do |format|
      format.html { redirect_to mountain_routes_url, notice: "Mountain route was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_mountain_route
      @mountain_route = MountainRoute.friendly.find(params[:id])
    end

    def mountain_route_params
      params.require(:mountain_route).permit(:activity_date, :sport_type, :area, :custom_difficulty, :equipped, :french_difficulty, :length, :multipitch, :multipitch_difficulty, :multipitch_lead, :multipitch_number, :multipitch_style, :name, :partner, :style, :description, images: [])
    end
end
