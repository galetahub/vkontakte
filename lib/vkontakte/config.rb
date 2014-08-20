module Vkontakte
  class Config < Hash
    # Creates an accessor that simply sets and reads a key in the hash:
    #
    # class Config < Hash
    #   hash_accessor :routes, :secret_key, :service_number, :project_name
    # end
    #
    # config = Config.new
    # config.routes = '/posts/message'
    # config[:routes] #=> '/posts/message'
    #
    def self.hash_accessor(*names) #:nodoc:
      names.each do |name|
        class_eval <<-METHOD, __FILE__, __LINE__ + 1
          def #{name}
            self[:#{name}]
          end

          def #{name}=(value)
            self[:#{name}] = value
          end
        METHOD
      end
    end
    
    hash_accessor :app_id, :app_secret, :debug, :logger, :format, :without_token
    
    def initialize(other={})
      merge!(other)
      self[:app_id] ||= "Vkontakte API ID"
      self[:app_secret] ||= "Vkontakte APP SECRET"
      self[:format] ||= :json
      self[:debug] ||= false
      self[:logger] ||= nil
      self[:without_token] ||= nil
    end
  end
end
