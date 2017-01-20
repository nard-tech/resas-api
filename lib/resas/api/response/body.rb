require 'nard/appi/response/body'

require_relative './validation_error'
require_relative './bad_request'
require_relative './forbidden'
require_relative './not_found'
require_relative './too_many_requests'

require_relative './base_error'

# RESAS (Regional Economy Society Analyzing System) に関する機能を格納する名前空間
# @see {https://resas.go.jp/}
# @see {https://opendata.resas-portal.go.jp/}
# @see {https://opendata.resas-portal.go.jp/docs/api/v1/index.html}
module Resas

  # RESAS API を扱うための Gem - トップの名前空間
  module Api

    module Response

      class Body < Nard::Appi::Response::Body

        # @return [Array or nil]
        def result
          @obj[ 'result' ]
        end

        # @return [String or nil]
        def message
          @obj[ 'message' ]
        end

        # @return [Integer or nil]
        def status_code
          _status_code = @obj[ 'statusCode' ]
          _status_code.present? ? _status_code.to_i : nil
        end

        # @return [String or nil]
        def description
          @obj[ 'description' ]
        end

        # @return [Boolean]
        def has_message?
          message.present?
        end

        # @return [Boolean]
        def has_description?
          description.present?
        end

        private

        def raise_error_if_needed
          unless result.present?
            e = error_class.new( self )
            binding.pry if Resas::Api.env.development? || Resas::Api.env.test?
            raise e
          end
        end

        def error_class
          case status_code
          when 400
            case message
            when 'Validation Failed.'
              Resas::Api::Response::ValidationError
            else
              Resas::Api::Response::BadRequest
            end
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

        def rescue_method_missing(e)
          e.message = <<-MSG
            Resas::Api::Response::Body#method_missing
            #{ e.message }
              method_name: #{ method_name }, @obj.class: #{ @obj.class }
          MSG
          binding.pry if Resas::Api.env.development? || Resas::Api.env.test?
          raise e
        end

      end

    end
  end
end
