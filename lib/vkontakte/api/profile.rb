module Vkontakte
  module Api
    module Profile
    
      def self.included(base)
        base.class_eval do
          define_method :profile do
            @profile ||= Standart.new(self)
          end
        end
      end
           
      class Standart < Api::Base
        # Данный метод возвращает информацию о том, установил ли текущий пользователь приложение или нет.
        # http://vk.com/developers.php?oid=-1&p=isAppUser
        #
        def isAppUser(options = {})
          call('isAppUser', options)
        end
        
        # Возвращает расширенную информацию о пользователях. 
        # http://vk.com/developers.php?oid=-1&p=users.get
        #
        def get(options = {})
          call('users.get', options)
        end
        
        # Возвращает баланс текущего пользователя на счету приложения в сотых долях голоса.
        # Отличается от метода secure.getBalance тем, что не требует безопасного соединения с сервером API. 
        # http://vk.com/developers.php?oid=-1&p=getUserBalance
        #
        def getUserBalance(options = {})
          call('getUserBalance', options)
        end
        
        # Получает настройки текущего пользователя в данном приложении.
        # http://vk.com/developers.php?oid=-1&p=getUserSettings
        #
        def getUserSettings(options = {})
          call('getUserSettings', options)
        end
        
        # Получает список идентификаторов пользователей, которые добавили заданный объект в свой список Мне нравится.
        # http://vk.com/developers.php?oid=-1&p=likes.getList
        #
        def likesGetList(options = {})
          call('likes.getList', options)
        end

        # Возвращает список идентификаторов пользователей, которые являются подписчиками пользователя. 
        # Идентификаторы пользователей в списке отсортированы в порядке убывания времени их добавления.
        # https://vk.com/dev/users.getFollowers
        #
        def getFollowers(options = {})
          call('users.getFollowers', options)
        end
      end
    end
  end
end
