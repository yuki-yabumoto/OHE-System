require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module Ohe
  class Application < Rails::Application
    config.load_defaults 6.1

    config.time_zone = "Tokyo"
    config.active_record.default_timezone = :local
    config.i18n.load_path +=
      Dir[Rails.root.join("config", "locales", "**", "*.{rb,yml}").to_s]
    config.i18n.default_locale = :ja

    config.generators do |g|
      g.skip_routes true
      g.helper false
      g.assets false
      g.test_framework :rspec
      g.controller_specs false
      g.view_specs false
    end

    config.hosts << '.example.com'
    config.action_view.field_error_proc = Proc.new { |html_tag, instance| html_tag }
  end
end
