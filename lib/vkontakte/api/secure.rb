module Vkontakte
  module Api
    module Secure
    
      def self.included(base)
        base.class_eval do
          define_method :secure do
            @secure ||= Standart.new(self)
          end
        end
      end
           
      class Standart < Api::Base
        
        def default_options
          { 
            :timestamp => Time.now.utc.to_i, 
            :random => Kernel.rand(10000),
            :client_secret => Vkontakte.config.app_secret 
          }
        end
        
        # Отправляет уведомление пользователю.
        # http://vkontakte.ru/developers.php?oid=-1&p=secure.sendNotification
        #
        def sendNotification(options = {})
          options = default_options.merge(options)
          call('secure.sendNotification', options)
        end
        
        # Возвращает платежный баланс (счет) приложения в сотых долях голоса. 
        #
        def getAppBalance(options = {})
          options = default_options.merge(options)
          call("secure.getAppBalance", options)
        end
        
        # Возвращает баланс пользователя на счету приложения в сотых долях голоса. 
        #
        def getBalance(options = {})
          options = default_options.merge(options)
          call("secure.getBalance", options)
        end
        
        # Списывает голоса со счета пользователя на счет приложения (в сотых долях).
        #
        def withdrawVotes(options = {})
          options = default_options.merge(options)
          call("secure.withdrawVotes", options)
        end
        
        # Выводит историю транзакций по переводу голосов между пользователями и приложением. 
        #
        def getTransactionsHistory(options = {})
          options = default_options.merge(options)
          call("secure.getTransactionsHistory", options)
        end
        
        # Поднимает пользователю рейтинг от имени приложения. 
        #
        def addRating(options = {})
          options = default_options.merge(options)
          call("secure.addRating", options)
        end
        
        # Устанавливает счетчик, который выводится пользователю жирным шрифтом в левом меню. 
        # Это происходит только в том случае, если пользователь добавил приложение в левое меню со страницы приложения, 
        # списка приложений или настроек.
        #
        def setCounter(options = {})
          options = default_options.merge(options)
          call("secure.setCounter", options)
        end
      end
    end
  end
end
