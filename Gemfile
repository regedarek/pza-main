source "https://rubygems.org"
ruby "3.2.2"

gem "rails", "~> 7.1.3", ">= 7.1.3.2"
gem 'rails-i18n', '~> 7.0.0'
gem "sprockets-rails"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "tailwindcss-rails"
gem "jbuilder"
gem "redis", ">= 4.0.1"
gem "bcrypt", "~> 3.1.7"
gem 'friendly_id', '~> 5.4.0'
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem 'pundit'
gem "bootsnap", require: false
gem "image_processing", "~> 1.2"
gem 'pg_search'
gem 'pagy', '~> 8.1'
gem "solid_queue"
gem "mission_control-jobs"

group :production do
  gem "aws-sdk-s3", require: false
  gem "appsignal"
end

group :development, :test do
  gem 'annotate'
  gem "debug", platforms: %i[ mri windows ]
end

group :development do
  gem "web-console"

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"
end

