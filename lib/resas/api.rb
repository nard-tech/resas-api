require 'resas/api/version'
require 'resas/api/client'
require 'resas/api/client/path'
require 'resas/api/client/response'
require 'resas/api/client/response/body'
require 'resas/api/client/response/body/result'

module Resas
  module Api

    class << self
      attr_accessor :api_version
    end

    self.api_version = 'v1-rc.1'

    # @return [Resas::Api::Client]
    def self.client
      @client ||= Resas::Api::Client.instance
    end

  end
end
