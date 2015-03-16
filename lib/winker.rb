require "winker/version"


require 'faraday'
require 'faraday_middleware'
require 'faraday/detailed_logger'
require 'hashie'
require 'active_support'
require 'active_support/core_ext'
require 'multi_json'


require 'winker/float'
require 'winker/device'
require 'winker/group'
require 'winker/scene'
require 'winker/connection'
require 'winker/api_methods'

module Winker

  module Parser
    def parse(body)
      case body
      when Hash
        body.each do |k,v|
          body[k] = parse(v)
        end
        OpenStruct.new(body)
      when Array
        body.map { |item| parse(item) }
      else
        body
      end
    end
  end
  
  module Configuration
    attr_accessor :client_id, :client_secret, :access_token, :refresh_token, :username, :password, :endpoint, :server_time_dif

    def configure
      yield self
    end
  end

  extend Parser
  extend Configuration
  extend Connection
  extend ApiMethods
  
end
