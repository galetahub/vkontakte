module Vkontakte
  module App
    # IFrame приложения
    # More info at http://vk.com/developers.php?id=-1_27971896&s=1
    #
    class Iframe < Base
      include Api::Photos
      include Api::Friends
      include Api::Groups

      attr_accessor :params

      # Основные параметры запуска приложения
      # При отображении приложения посредством flashVars или строки запроса (для IFrame приложений)
      # в него передаются следующие параметры: api_url, api_id, user_id, sid, secret, group_id ...
      # http://vk.com/developers.php?id=-1_27971896&s=1
      #
      def params=(value)
        @params = value.symbolize_keys

        if @params[:access_token] && auth.nil?
          self.auth = { 'access_token' => @params[:access_token] }
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

      # результат выполнения API-запроса, формирующийся при просмотре приложения.
      # Параметры этого запроса можно ввести в разделе редактирования приложения.
      # Например, для получения информации об указанных пользователях, можно использовать следующий запрос:
      #   method=getProfiles&uids={user_id},{viewer_id},1,6492&format=json&v=2.0
      #
      def api_result
        @api_result ||= MultiJson.decode(params[:api_result])
      end

      protected

        # это ключ, необходимый для авторизации пользователя на стороннем сервере
        #
        def auth_key
          Utils.md5( [@config[:app_id], params[:viewer_id], @config[:app_secret]].join('_') )
        end
    end
  end
end
