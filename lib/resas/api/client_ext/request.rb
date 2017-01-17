require 'active_support'
require 'active_support/core_ext'
require 'active_support/concern'

require 'uri'

require_relative './../client/util/path_settings_normalizer'
require_relative './../client/util/request_settings_normalizer'
require_relative './../response/body'

# RESAS (Regional Economy Society Analyzing System) に関する機能を格納する名前空間
# @see {https://resas.go.jp/}
module Resas

  # RESAS API を扱うための Gem - トップの名前空間
  # @see {https://opendata.resas-portal.go.jp/}
  # @see {https://opendata.resas-portal.go.jp/docs/api/v1/index.html}
  module Api

    module ClientExt

      # RESAS API へのリクエストを処理するメソッドを格納するモジュール
      module Request

        extend ActiveSupport::Concern

        included do
          undef :post
        end

        # GET メソッドで RESAS API へアクセスするメソッド
        # @return [Resas::Api::Response::Body]
        def get( *args )
          super
        end

        # @return [URI::HTTPS or URI::Generic]
        def path( *args )
          path, options, *others = Client::Util::PathSettingsNormalizer.process( args )
          full = others.shift

          uri = ( full ? URI( "#{ base_endpoint }/#{ path }" ) : URI( path ) )
          uri.query = options.to_query if options.present?
          uri
        end

        private

        # @return [Resas::Api::Response::Body]
        def request( method, *args )
          _path, options, parse_json, generate_instance = Client::Util::RequestSettingsNormalizer.process( args )
          con = connection( parse_json: parse_json, generate_instance: generate_instance )
          response = __request__( con, method, _path, options )
          Resas::Api::Response::Body.new( response.body, self, _path, options )
        end

      end
    end
  end
end
