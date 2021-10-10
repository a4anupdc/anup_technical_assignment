# frozen_string_literal: true

require 'capybara/cucumber'
require 'capybara-screenshot/cucumber'
require 'rest-client'
require 'rspec'
require 'selenium-webdriver'

TODO_APP_BASE_URL = 'https://todomvc.com/examples/react/#/'
TODO_APP_API_URL = 'https://jsonplaceholder.typicode.com/todos'

Capybara.configure do |config|
  config.default_driver    = :selenium
  config.run_server        = false
  config.default_selector  = :css
  config.default_max_wait_time = 30
  config.app_host = 'https://todomvc.com/examples/react/#/'
end

Capybara.register_driver :selenium do |app|
  caps = Selenium::WebDriver::Remote::Capabilities.new(accept_insecure_certs: true)
  Capybara::Selenium::Driver.new(app, desired_capabilities: caps)
end
