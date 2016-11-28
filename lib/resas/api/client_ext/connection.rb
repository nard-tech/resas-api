require 'faraday'
require 'faraday_middleware'

# RESAS (Regional Economy Society Analyzing System) に関する機能を格納する名前空間
# @see {https://resas.go.jp/}
module Resas

  # RESAS API を扱うための Gem - トップの名前空間
  # @see {https://opendata.resas-portal.go.jp/}
  # @see {https://opendata.resas-portal.go.jp/docs/api/v1-rc.1/index.html}
  module Api

    module ClientExt

      # Gem 'Faraday' を用いて RESAS API へ接続する機能を格納するモジュール
      module Connection

        private

        # @return [Faraday::Connection]
        def connection( parse_json:, generate_instance: )
          # @note
          # {https://github.com/lostisland/faraday_middleware/wiki}
          # Important: same as with Rack middleware, the order of middleware on a Faraday stack is significant. General guidelines:
          # 1. put request middleware first, in order of importance;
          # 2. put response middleware second, [in the reverse order of importance];
          # 3. ensure that the adapter is always last.
          Faraday::Connection.new( options_for_connection ) do | con |
            con.request :json

            # URL をエンコードする
            con.use Faraday::Request::UrlEncoded

            # 結果のJSONをパースする
            con.response :json if parse_json

            # アダプターを選択する
            con.adapter( adapter )
          end
        end

        # @return [Hash]
        def options_for_connection
          {
            headers: {
              'X-API-KEY' => access_key,
              'Content-Type' => "application/#{ format };charset=UTF-8"
            },
            url: base_endpoint,
          }
        end

      end
    end
  end
end
