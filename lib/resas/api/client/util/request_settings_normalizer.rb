require_relative './base_normalizer'

# RESAS (Regional Economy Society Analyzing System) に関する機能を格納する名前空間
# @see {https://resas.go.jp/}
module Resas

  # RESAS API を扱うための Gem - トップの名前空間
  # @see {https://opendata.resas-portal.go.jp/}
  # @see {https://opendata.resas-portal.go.jp/docs/api/v1/index.html}
  module Api

    class Client

      # RESAS API を扱うための補助的な機能を格納する名前空間
      module Util

        # RESAS API へのリクエストを処理するクラス
        class RequestSettingsNormalizer < BaseNormalizer

          attr_reader :parse_json, :generate_instance

          private

          def set_special_options( options )
            @parse_json = normalize_boolean_option( options, :parse_json, default: true )
            @generate_instance = normalize_boolean_option( options, :generate_instance, default: false )
          end

          def special_options
            [ @parse_json, @generate_instance ]
          end

        end

      end

    end
  end
end
