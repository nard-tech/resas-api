require_relative './base_error'

# RESAS (Regional Economy Society Analyzing System) に関する機能を格納する名前空間
# @see {https://resas.go.jp/}
# @see {https://opendata.resas-portal.go.jp/}
# @see {https://opendata.resas-portal.go.jp/docs/api/v1/index.html}
module Resas

  # RESAS API を扱うための Gem - トップの名前空間
  module Api

    module Response

      class ValidationError < BaseError
      end

    end
  end
end
