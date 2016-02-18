require 'rails_helper'
require 'capybara/rspec'

RSpec.configure do |config|
  config.include Rails.application.routes.url_helpers
  config.include FactoryGirl::Syntax::Methods
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.include Devise::TestHelpers, type: :controller
  config.include Devise::TestHelpers, type: :view

  config.include Capybara::DSL
end
