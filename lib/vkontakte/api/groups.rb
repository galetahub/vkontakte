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
        # http://vkontakte.ru/developers.php?oid=-1&p=groups.get
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
      end
    end
  end
end
