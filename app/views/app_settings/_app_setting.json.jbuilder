json.extract! app_setting, :id, :name, :code, :checkbox, :number, :setting_type, :created_at, :updated_at
json.url app_setting_url(app_setting, format: :json)
