module Vkontakte
  module Api
    module Likes

      def self.included(base)
        base.class_eval do
          define_method :likes do
            @likes ||= Standart.new(self)
          end
        end
      end

      class Standart < Api::Base
        # http://vk.com/developers.php?oid=-1&p=likes.getList
        #
        def getList(options = {})
          call('likes.getList', options)
        end

        # http://vk.com/developers.php?o=-1&p=likes.isLiked
        #
        def isLiked(options = {})
          call('likes.isLiked', options)
        end
      end
    end
  end
end