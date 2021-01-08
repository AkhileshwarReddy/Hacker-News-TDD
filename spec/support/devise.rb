require_relative './controller_macros'

RSpec.configure do |config|
    config.include Devise::Test::ControllerHelpers, :type => :action_controller
    config.extend ControllerMacros, :type => :controller
end