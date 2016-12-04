# RESAS (Regional Economy Society Analyzing System) に関する機能を格納する名前空間
# @see {https://resas.go.jp/}
module Resas

  # RESAS API を扱うための Gem - トップの名前空間
  # @see {https://opendata.resas-portal.go.jp/}
  # @see {https://opendata.resas-portal.go.jp/docs/api/v1-rc.1/index.html}
  module Api

    module Response

      class BaseError < StandardError

        def initialize( body )
          @body = body
        end

        def message
          "#{ @body.message } (#{ path })"
        end

        private

        def path
          @body.path( full: true )
        end

      end

    end
  end
end