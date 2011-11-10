require "rubygems"
require "bundler/setup"

$:.push File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))
require "vkontakte"
require "fakeweb"

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

Vkontakte.setup do |config|
  config.app_id = 10000
  config.app_secret = "supersecret"
  config.format = :json
  config.debug = false
  config.logger = nil
end

RSpec.configure do |config|
  # Remove this line if you don't want RSpec's should and should_not
  # methods or matchers
  require 'rspec/expectations'
  config.include RSpec::Matchers

  # == Mock Framework
  config.mock_with :rspec
  
  config.before(:suite) do
    FakeWeb.allow_net_connect = false
  end
  
  config.after(:suite) do
    FakeWeb.allow_net_connect = true
  end
end
