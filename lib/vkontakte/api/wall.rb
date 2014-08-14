module Vkontakte
  module Api
    module Wall

      def self.included(base)
        base.class_eval do
          define_method :wall do
            @wall ||= Standart.new(self)
          end
        end
      end

      class Standart < Api::Base
        # https://vk.com/dev/wall.get
        #
        def get(options = {})
          call('wall.get', options)
        end

        # https://vk.com/dev/wall.getById
        #
        def getById(options = {})
          call('wall.getById', options)
        end

        # https://vk.com/dev/wall.getComments
        #
        def getComments(options = {})
          call('wall.getComments', options)
        end

        # https://vk.com/dev/wall.getReposts
        #
        def getReposts(options = {})
          call('wall.getReposts', options)
        end
      end
    end
  end
end