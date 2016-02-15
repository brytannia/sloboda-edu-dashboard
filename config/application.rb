require File.expand_path('../boot', __FILE__)

require'rails'
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'sprockets/railtie'
Bundler.require(*Rails.groups)

module SlobodaEduDashboard
  class Application < Rails::Application
    # config.time_zone = 'Central Time (US & Canada)'

    # config.i18n.load_path +=
    # Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    config.generators do |g|
      g.factory_girl false
    end
  end
end
