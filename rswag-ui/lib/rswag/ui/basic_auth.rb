# frozen_string_literal: true

require 'rack/auth/basic'

module Rswag
  module Ui
    # Extend Rack HTTP Basic Authentication, as per RFC 2617.
    # @api private
    #
    class BasicAuth < ::Rack::Auth::Basic
      def call(env)
        return @app.call(env) unless env_matching_path(env)

        super(env)
      end

      private

      def env_matching_path(env)
        path = URI.parse(env['PATH_INFO']).path
        Rswag::Ui.config.config_object[:urls].find { |endpoint| /#{endpoint[:url]}/ =~ path }
      end
    end
  end
end
