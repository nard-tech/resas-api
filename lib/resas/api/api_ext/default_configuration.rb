require 'faraday'

# RESAS (Regional Economy Society Analyzing System) に関する機能を格納する名前空間
# @see {https://resas.go.jp/}
module Resas

  # RESAS API を扱うための Gem - トップの名前空間
  # @see {https://opendata.resas-portal.go.jp/}
  # @see {https://opendata.resas-portal.go.jp/docs/api/v1/index.html}
  module Api

    module ApiExt

      # RESAS API への接続の設定を扱うモジュール
      # @note
      #   Constants:
      #     OPTIONS_KEYS
      #     DEFAULT_ACCESS_KEY, DEFAULT_BASE_URL, DEFAULT_FORMAT, DEFAULT_API_VERSION, DEFAULT_ADAPTER
      module DefaultConfiguration

        include Nard::Appi::ApiExt::DefaultConfiguration

        default(
          # APIキー
          # @see {https://opendata.resas-portal.go.jp/form.html}
          # @return [String]
          access_key: ENV[ 'RESAS_API_ACCESS_KEY' ],

          # RESAS API エンドポイント
          # @return [String]
          # @see {https://opendata.resas-portal.go.jp/docs/api/v1/index.html}
          base_url: 'https://opendata.resas-portal.go.jp',

          # API から取得する値のフォーマット
          # @return [String]
          format: :json,

          # 接続先の RESAS API のバージョン
          # @return [String]
          # @note Default: v1
          # @note この Gem のバージョンではない！ Gem のバージョンは、Resas::Api::VERSION または Resas::Api.gem_version で取得する。
          # @todo [Future] API の仕様が大幅に変更された場合の場合分け
          api_version: 'v1',

          # Faraday で使用する HTTP クライアントの種類
          # @return [Net::HTTP] (Default)
          adapter: Faraday.default_adapter
        )

      end

    end
  end
end
