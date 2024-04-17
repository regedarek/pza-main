class AppSettingsController < ApplicationController
  before_action :set_app_setting, only: %i[ show edit update destroy ]

  # GET /app_settings or /app_settings.json
  def index
    @app_settings = AppSetting.all

    authorize @app_settings
  end

  # GET /app_settings/1 or /app_settings/1.json
  def show
    authorize @app_setting
  end

  # GET /app_settings/new
  def new
    @app_setting = AppSetting.new

    if params[:app_setting].present?
      @app_setting.assign_attributes(app_setting_params)
    end

    authorize @app_setting
  end

  # GET /app_settings/1/edit
  def edit
    authorize @app_setting
  end

  # POST /app_settings or /app_settings.json
  def create
    @app_setting = AppSetting.new(app_setting_params)

    authorize @app_setting

    respond_to do |format|
      if @app_setting.save
        format.html { redirect_to app_setting_url(@app_setting), notice: "App setting was successfully created." }
        format.json { render :show, status: :created, location: @app_setting }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @app_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /app_settings/1 or /app_settings/1.json
  def update
    authorize @app_setting

    respond_to do |format|
      if @app_setting.update(app_setting_params)
        format.html { redirect_to app_setting_url(@app_setting), notice: "App setting was successfully updated." }
        format.json { render :show, status: :ok, location: @app_setting }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @app_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /app_settings/1 or /app_settings/1.json
  def destroy
    @app_setting.destroy!

    authorize @app_setting

    respond_to do |format|
      format.html { redirect_to app_settings_url, notice: "App setting was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_app_setting
      @app_setting = AppSetting.friendly.find(params[:id]) rescue nil
      redirect_to new_app_setting_path(app_setting: { slug: params[:id] }), notice: "Dodaj: #{params[:id]}" if @app_setting.nil?
    end

    # Only allow a list of trusted parameters through.
    def app_setting_params
      params.require(:app_setting).permit(:name, :slug, :checkbox, :number, :setting_type, :content)
    end
end
