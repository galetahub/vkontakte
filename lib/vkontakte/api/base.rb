module Vkontakte
  module Api
    class Base
      attr_accessor :app
      
      delegate :call, :to => :app
      
      def initialize(base)
        @app = base
      end
    end
  end
end
