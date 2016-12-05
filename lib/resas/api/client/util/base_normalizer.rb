require 'nard/appi/client/util/base_normalizer'

# RESAS (Regional Economy Society Analyzing System) に関する機能を格納する名前空間
# @see {https://resas.go.jp/}
module Resas

  # RESAS API を扱うための Gem - トップの名前空間
  # @see {https://opendata.resas-portal.go.jp/}
  # @see {https://opendata.resas-portal.go.jp/docs/api/v1-rc.1/index.html}
  module Api

    class Client

      # RESAS API を扱うための補助的な機能を格納する名前空間
      module Util

        # API へ送る情報を処理するクラス（基底クラス）
        class BaseNormalizer < Nard::Appi::Client::Util::BaseNormalizer

          private

          def normalize_key( key )
            key.to_s.camelize( :lower )
          end

          def normalize_value( value )
            [ value ].flatten.join( ',' )
          end

          def active_value?( value )
            value.present?
          end

        end

      end

    end
  end
end
