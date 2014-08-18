module Vkontakte
  module Api
    module Friends

      def self.included(base)
        base.class_eval do
          define_method :friends do
            @friends ||= Standart.new(self)
          end
        end
      end

      class Standart < Api::Base
        # Возвращает список идентификаторов друзей пользователя или
        # расширенную информацию о друзьях пользователя (при использовании параметра fields).
        # https://vk.com/dev/friends.get
        #
        def get(options = {})
          call('friends.get', options)
        end

        # Возвращает список идентификаторов друзей текущего пользователя, которые установили данное приложение.
        #
        def getAppUsers(options = {})
          call('friends.getAppUsers', options)
        end

        # Возвращает список идентификаторов, находящихся на сайте друзей, текущего пользователя.
        #
        def getOnline(options = {})
          call('friends.getOnline', options)
        end

        # Возвращает список идентификаторов общих друзей между парой пользователей.
        #
        def getMutual(options = {})
          call('friends.getMutual', options)
        end
      end
    end
  end
end
