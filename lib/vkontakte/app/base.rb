require 'httparty'

module Vkontakte
  module App
    class Base
      include ::HTTParty

      base_uri "https://api.vk.com"
      format Vkontakte.config.format
      debug_output Vkontakte.config.logger

      attr_accessor :auth

      def initialize(app_id = nil, app_secret = nil)
        @config = {
          :app_id => (app_id || Vkontakte.config.app_id),
          :app_secret => (app_secret || Vkontakte.config.app_secret)
        }
      end

      # http://vk.com/developers.php?oid=-1&p=%D0%90%D0%B2%D1%82%D0%BE%D1%80%D0%B8%D0%B7%D0%B0%D1%86%D0%B8%D1%8F
      # Site auth:
      # https://oauth.vk.com/access_token?
      #   client_id=APP_ID&
      #   client_secret=APP_SECRET&
      #   code=7a6fa4dff77a228eeda56603b8f53806c883f011c40b72630bb50df056f6479e52a
      #
      # Server auth:
      # https://oauth.vk.com/access_token?client_id=' + APP_ID + '&client_secret=' + APP_SECRET + '&grant_type=client_credentials'
      #
      # Response:
      #   {"access_token":"533bacf01e11f55b536a565b57531ac114461ae8736d6506a3", "expires_in":43200, "user_id":6492}
      #
      def authorize(code = nil, options = {})
        options = {
          :client_id => @config[:app_id],
          :client_secret => @config[:app_secret],
          :code => code
        }.merge(options)

        # Server auth
        if options[:code].blank?
          options.delete(:code)
          options[:grant_type] = 'client_credentials'
        end

        self.class.base_uri "https://oauth.vk.com"
        @auth = get("/access_token", options)
      end

      # Check if app is authorized
      #
      def authorized?
        auth && auth['access_token']
      end

      # Выполнение запросов к API
      # https://api.vk.com/method/METHOD_NAME?PARAMETERS&access_token=ACCESS_TOKEN
      #   METHOD_NAME – название метода из списка функций API,
      #   PARAMETERS – параметры соответствующего метода API,
      #   ACCESS_TOKEN – ключ доступа, полученный в результате успешной авторизации приложения.
      # Example:
      # https://api.vk.com/method/getProfiles?uid=66748&access_token=533bacf01e11f55b536a565b57531ac114461ae8736d6506a3
      #
      # More info: http://vk.com/developers.php?oid=-1&p=%D0%92%D1%8B%D0%BF%D0%BE%D0%BB%D0%BD%D0%B5%D0%BD%D0%B8%D0%B5_%D0%B7%D0%B0%D0%BF%D1%80%D0%BE%D1%81%D0%BE%D0%B2_%D0%BA_API
      #
      def call(method_name, params = {})
        params[:access_token] ||= @auth['access_token'] if authorized?

        unless params[:access_token].blank?
          self.class.base_uri "https://api.vk.com"
          get("/method/#{method_name}", params)
        else
          raise VkException.new(method_name, {
            :error => 'access_token is blank',
            :error_description => 'You need first authorize app before call API methods.'
          })
        end
      end

      protected

        def get(method_name, options = {})
          response = self.class.get(method_name, :query => options)

          if response['error']
            raise VkException.new(method_name, response)
          else
            return response
          end
        end
    end

    # Errors
    # {"error":"invalid_grant","error_description":"Code is expired."}
    # {"error":{"error_code":5,"error_msg":"User authorization failed: invalid application type","request_params":[{"key":"oauth","value":"1"},{"key":"method","value":"getProfiles"},{"key":"uid","value":"66748"},{"key":"access_token","value":"533bacf01e11f55b536a565b57531ac114461ae8736d6506a3"}]}}
    #
    class VkException < Exception
      def initialize(method_name, options)
        error_hash = options.symbolize_keys
        @message = "Error in #{method_name}: "

        if error_hash[:error].is_a?(Hash)
          @message += error_hash[:error].inspect
        else
          @message += [error_hash[:error], error_hash[:error_description]].join('-')
        end

        super @message
      end
    end
  end
end
