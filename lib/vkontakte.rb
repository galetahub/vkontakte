require 'active_support/core_ext/module/attribute_accessors'
require 'active_support/core_ext/object'
require 'active_support/core_ext/string'

module Vkontakte
  autoload :Config, 'vkontakte/config'
  autoload :Utils, 'vkontakte/utils'
  
  module App
    autoload :Base, 'vkontakte/app/base'
    autoload :Iframe, 'vkontakte/app/iframe'
  end
  
  mattr_accessor :config
  @@config = Config.new
  
  def self.setup(&block)
    yield config
  end
end
