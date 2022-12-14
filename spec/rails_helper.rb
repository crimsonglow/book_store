require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'

abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'simplecov'
SimpleCov.start
# SimpleCov.start 'rails' do
#   add_filter('/admin')
# end
require 'rspec/rails'
require 'capybara/rails'
require 'capybara-screenshot/rspec'
require 'devise'
require 'capybara'
require 'capybara/rspec'
require 'selenium-webdriver'
require 'site_prism'

Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end
RSpec.configure do |config|
  config.include Warden::Test::Helpers
  config.include FactoryBot::Syntax::Methods
  config.include Devise::Test::IntegrationHelpers, type: :controller
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.extend ControllerMacros, type: :controller
  config.extend FeatureMacros, type: :feature

  config.fixture_path = Rails.root.join('/spec/fixtures')

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!

  Capybara.register_driver :selenium_firefox do |app|
    Capybara::Selenium::Driver.new(app, browser: :firefox)
  end
  Capybara.javascript_driver = :selenium_firefox
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
