require_relative './forbidden'
require_relative './not_found'
require_relative './too_many_requests'
require_relative './base_error'

# RESAS (Regional Economy Society Analyzing System) に関する機能を格納する名前空間
# @see {https://resas.go.jp/}
module Resas

  # RESAS API を扱うための Gem - トップの名前空間
  # @see {https://opendata.resas-portal.go.jp/}
  # @see {https://opendata.resas-portal.go.jp/docs/api/v1-rc.1/index.html}
  module Api

    module Response

      class Body

        def initialize( h, client, path, options )
          @h = h

          @client = client
          @path = path
          @options = options

          raise_error_if_needed
        end

        # @return [URI::HTTPS or URI::Generic]
        def path( full: true )
          options = @options.dup.merge( full: full )
          @client.path( @path, options )
        end

        # @return [Array or nil]
        def result
          @h[ 'result' ]
        end

        # @return [String or nil]
        def message
          @h[ 'message' ]
        end

        # @return [Integer or nil]
        def status_code
          _status_code = @h[ 'statusCode' ]
          _status_code.present? ? _status_code.to_i : nil
        end

        # @return [String or nil]
        def description
          @h[ 'description' ]
        end

        # @return [Boolean]
        def has_message?
          message.present?
        end

        # @return [Boolean]
        def has_description?
          description.present?
        end

        def method_missing( method_name, *args, &block )
          return super unless @h.respond_to?( method_name )
          @h.send( method, *args, &block )
        rescue NoMethodError => e
          e.message = <<-MSG
            Resas::Api::Response::Body#method_missing
            #{ e.message }
              method_name: #{ method_name }, @h.class: #{ @h.class }
          MSG
          # binding.pry
          raise e
        end

        def respond_to?( method, include_all = true )
          return @h.respond_to?( method, include_all ) || super
        end

        private

        def raise_error_if_needed
          raise error_class.new( @h ) unless result.present?
        end

        def error_class
          case status_code
          when 403
            Resas::Api::Response::Forbidden
          when 404
            Resas::Api::Response::NotFound
          when 429
            Resas::Api::Response::TooManyRequests
          else
            Resas::Api::Response::BaseError
          end
        end

      end

    end
  end
end
