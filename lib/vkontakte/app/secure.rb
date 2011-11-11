module Vkontakte
  module App
    # Данный метод доступен только с серверной стороны.
    # More info at http://vkontakte.ru/developers.php?id=-1_27971896&s=1
    #
    class Secure < Base
      include Api::Secure
      
      def initialize(app_id = nil, app_secret = nil)
        super
        authorize
      end
    end
  end
end
