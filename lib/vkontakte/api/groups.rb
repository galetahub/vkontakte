module Vkontakte
  module Api
    module Groups

      def self.included(base)
        base.class_eval do
          define_method :groups do
            @groups ||= Standart.new(self)
          end
        end
      end

      class Standart < Api::Base
        # Возвращает список групп указанного пользователя.
        # http://vk.com/developers.php?oid=-1&p=groups.get
        #
        def get(options = {})
          call('groups.get', options)
        end

        # Возвращает информацию о заданной группе или о нескольких группах.
        #
        def getById(options = {})
          call('groups.getById', options)
        end

        # Возвращает информацию о том является ли пользователь участником заданной группы.
        #
        def isMember(options = {})
          call('groups.isMember', options)
        end

        # Возвращает список участников группы.
        #
        def getMembers(options = {})
          call('groups.getMembers', options)
        end

        # Добавляет как участника группы
        # http://vk.com/developers.php?o=-1&p=groups.join
        #
        def join(options = {})
          call('groups.join', options)
        end

        # Добавляет как участника группы
        # http://vk.com/developers.php?o=-1&p=groups.leave
        #
        def leave(options = {})
          call('groups.leave', options)
        end
      end
    end
  end
end
