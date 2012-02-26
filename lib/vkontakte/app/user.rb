module Vkontakte
  module App
    # Vkontakte user
    #
    #   user = Vkontakte::App::User.fetch(uid, :access_token => ACCESS_TOKEN)
    #
    # or
    #
    #   user = Vkontakte::App::User.new(uid, :access_token => ACCESS_TOKEN)
    #   user.fetch
    # 
    class User < Base
      include Api::Photos
      include Api::Friends
      include Api::Groups
      include Api::Profile
      
      attr_reader :identifier
      
      def initialize(identifier, options = {})
        super(options[:app_id], options[:app_secret])
        @identifier = identifier
        @auth = { 'access_token' => options[:access_token] } if options.has_key?(:access_token)
        photos.default_params = { :uid => @identifier }
      end
      
      def fetch(options = {})
        options = { :uids => @identifier }.merge(options)
        profile.get( options )
      end
      
      def self.fetch(identifier, options = {})
        new(identifier, options).fetch
      end
    end
  end
end
