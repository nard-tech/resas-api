require 'uri'
require 'net/http'
require 'singleton'

module Resas
  module Api
    class Client

      include Singleton

      API_ENDPOINT = 'https://opendata.resas-portal.go.jp'

      def initialize
        uri = ::URI.parse( API_ENDPOINT )

        @http = Net::HTTP.new( uri.host, uri.port )
        @http.use_ssl = ( uri.scheme == 'https' )

        @header = { 'X-API-KEY' => ENV[ 'RESAS_API_ACCESS_KEY' ], 'Content-Type' => 'application/json' }
        # @http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      end

      def get( *args )
        api_version = Resas::Api.api_version
        response = @http.get( Resas::Api::Client::Path.get( api_version, *args ), @header )
        Resas::Api::Client::Response.new( response )
      end

      # @return [URI::HTTP]
      def path( *args )
        api_version = Resas::Api.api_version
        URI.join( API_ENDPOINT, Resas::Api::Client::Path.get( api_version, *args ) )
      end

    end

  end
end
