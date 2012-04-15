module Vkontakte
  module Api
    class Base
      attr_accessor :app, :default_params

      delegate :call, :to => :app

      def initialize(base)
        @app = base
      end

      def default_params
        @default_params ||= {}
      end

      def call(method_name, params = {})
        params = default_params.merge(params)
        @app.call(method_name, params)['response']
      end
    end
  end
end
