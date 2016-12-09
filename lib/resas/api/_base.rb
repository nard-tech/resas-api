require 'nard/appi'

require_relative 'version'
require_relative 'api_ext/default_configuration'

# RESAS (Regional Economy Society Analyzing System) に関する機能を格納する名前空間
# @see {https://resas.go.jp/}
module Resas

  # RESAS API を扱うための Gem - トップの名前空間
  # @see {https://opendata.resas-portal.go.jp/}
  # @see {https://opendata.resas-portal.go.jp/docs/api/v1-rc.1/index.html}
  module Api

    include Nard::Appi::ApiExt::Version
    include Nard::Appi::ApiExt::Client
    include Nard::Appi::ApiExt::Configuration
    include Nard::Appi::ApiExt::Environment

    include ApiExt::DefaultConfiguration

    include Nard::Appi::ApiExt::Initializer

    # クライアントのオブジェクトを返すメソッド
    # @param options [Hash] オプション
    # @return [Resas::Api::Client]
    def self.client( options = {} )
      super( Resas::Api, options )
    end

    def self.method_missing( method, *args, &block )
      return super unless client.respond_to?( method )
      client.send( method, *args, &block )
    end

    def self.respond_to?( method, include_all = false )
      return client.respond_to?( method, include_all ) || super
    end

  end
end
