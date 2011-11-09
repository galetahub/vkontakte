require 'digest/md5'

module Vkontakte
  module App
    # IFrame приложения
    # More info at http://vkontakte.ru/developers.php?id=-1_27971896&s=1
    #
    class Iframe < Base
      attr_accessor :params
      
      def params=(value)
        @params = value.symbolize_keys
        
        if @params[:access_token] && auth.nil?
          auth = { 'access_token' => @params[:access_token] }
        end
        
        @params
      end
      
      # Этот параметр приходит, если в приложении включена система платежей (во вкладке Платежи при редактировании приложения).
      # auth_key вычисляется на сервере ВКонтакте следующим образом:
      #   auth_key = md5(api_id + '_' + viewer_id + '_' + api_secret)
      #
      def valid_auth_key?
        !params[:auth_key].blank? && params[:auth_key] == auth_key
      end
      
      # Переменная language может принимать следующие значения:
      #
      #  0 – русский язык.
      #  1 – украинский язык.
      #  2 – белорусский язык.
      #  3 – английский язык.
      #
      def language
        return :ru if params[:language].blank?
        case params[:language].to_s
          when '0' then :ru
          when '1' then :uk
          when '2' then :be
          when '3' then :en
        end
      end
      
      protected
      
        def auth_key
          Utils.md5( [@config[:app_id], params[:viewer_id], @config[:app_secret]].join('_') )
        end
    end
  end
end
