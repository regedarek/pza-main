class MountainRoutesController < ApplicationController
  before_action :set_mountain_route, only: %i[ show edit update destroy ]

  def index
    mountain_routes = MountainRoute.arel_table
    query = mountain_routes[:id].not_eq(nil)
    query = query.and(mountain_routes[:activity_date].gteq( Date.new(params.dig(:year).to_i, 1, 1).beginning_of_year)) if params.dig(:year).present?
    query = query.and(mountain_routes[:sport_type].eq(params.dig(:sport_type))) if params.dig(:sport_type).present?

    @mountain_routes = MountainRoute.where(query).search(params.dig(:search)).order(activity_date: :desc) if params.dig(:search).present?
    @mountain_routes = MountainRoute.where(query).order(activity_date: :desc) if params.dig(:search).blank?

    @mountain_routes = MountainRoutePolicy::Scope.new(current_user, @mountain_routes).resolve

    @pagy, @mountain_routes = pagy(@mountain_routes)
  end

  def show
    authorize @mountain_route
  end

  def new
    @mountain_route = MountainRoute.new

    authorize @mountain_route

    if params[:mountain_route].present?
      @mountain_route.assign_attributes(mountain_route_params)
    else
      @mountain_route.assign_attributes(sport_type: current_user.last_sport_type) if current_user.last_sport_type.present?
    end

    @mountain_route.partner_ids = [current_user.id]
  end

  def edit
    authorize @mountain_route

    @mountain_route.assign_attributes(mountain_route_params) if params[:mountain_route].present?
  end

  def create
    @mountain_route = current_user.mountain_routes.new(mountain_route_params)
    @mountain_route.user = current_user

    authorize @mountain_route

    respond_to do |format|
      if @mountain_route.save
        current_user.update(last_sport_type: @mountain_route.sport_type)
        format.html { redirect_to mountain_route_url(@mountain_route), notice: t('mountain_routes.create.success') }
        format.json { render :show, status: :created, location: @mountain_route }
      else
        format.html { render :new, status: :unprocessable_entity, locals: { mountain_route: @mountain_route, params: mountain_route_params } }
        format.json { render json: @mountain_route.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @mountain_route

    respond_to do |format|
      if @mountain_route.update(mountain_route_params)
        current_user.update(last_sport_type: @mountain_route.sport_type)
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
      params.require(:mountain_route).permit(
        :activity_date, :sport_type, :area, :custom_difficulty, :equipped,
        :french_difficulty, :length, :multipitch, :multipitch_difficulty,
        :multipitch_lead, :multipitch_number, :multipitch_style, :name,
        :partner, :style, :description, :hidden,
        images: [], partner_ids: []
      )
    end
end
