require "rubygems"
require "bundler/setup"

$:.push File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))
require "vkontakte"

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  # Remove this line if you don't want RSpec's should and should_not
  # methods or matchers
  require 'rspec/expectations'
  config.include RSpec::Matchers

  # == Mock Framework
  config.mock_with :rspec
end
