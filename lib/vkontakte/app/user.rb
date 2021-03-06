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
      include Api::Wall
      include Api::Likes

      attr_reader :identifier

      def initialize(identifier, options = {})
        super(options[:app_id], options[:app_secret])
        @identifier = identifier
        @auth = { 'access_token' => options[:access_token] } if options.has_key?(:access_token)
        photos.default_params = { :uid => @identifier }
      end

      def fetch(options = {})
        options = { :user_ids => @identifier }.merge(options)
        profile.get( options )
      end

      def fetch_followers(options = {})
        options = { :user_id => @identifier }.merge(options)
        profile.getFollowers(options)
      end

      def fetch_friends(options = {})
        options = { :user_id => @identifier }.merge(options)
        friends.get(options)
      end
        
      def self.fetch(identifier, options = {})
        new(identifier, options).fetch
      end
    end
  end
end
