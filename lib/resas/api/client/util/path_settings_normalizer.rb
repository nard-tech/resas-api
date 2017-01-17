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

        # RESAS API のパスを処理するクラス
        class PathSettingsNormalizer < BaseNormalizer

          attr_reader :full

          private

          def set_special_options( options )
            @full = normalize_boolean_option( options, :full, default: true )
          end

          def special_options
            [ @full ]
          end

        end

      end
    end
  end
end
