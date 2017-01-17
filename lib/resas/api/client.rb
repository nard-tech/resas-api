require 'nard/appi/client'

require 'active_support'
require 'active_support/core_ext'
require 'uri'

# RESAS (Regional Economy Society Analyzing System) に関する機能を格納する名前空間
# @see {https://resas.go.jp/}
# @see {https://opendata.resas-portal.go.jp/}
# @see {https://opendata.resas-portal.go.jp/docs/api/v1/index.html}
module Resas

  # RESAS API を扱うための Gem - トップの名前空間
  module Api

    # RESAS API へアクセスするクライアントのクラス
    # @note 実際の通信には Gem 'Faraday' を利用する。
    class Client < Nard::Appi::Client

      client_for Resas::Api
      concerns :Connection, :Request, :Endpoints, under: 'resas/api/client_ext'

      # API のエンドポイント（APIのバージョンを含む）
      # @return [URI::HTTPS]
      def base_endpoint
        URI.join( base_url, "/api/#{ api_version }" )
      end

    end
  end
end
