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
    attr_accessor :client_id, :client_secret, :access_token, :refresh_token, :username, :password, :endpoint, :server_time_dif, :wait_for_updates

    def configure
      self.wait_for_updates = true
      yield self
    end
  end

  def self.wait_for_update(should_i_wait = true)
    _default_setting = self.wait_for_updates
    self.wait_for_updates = should_i_wait
    begin
      yield
    rescue Exception => e
      self.wait_for_updates = _default_setting
      raise e
    end
  end


  extend Parser
  extend Configuration
  extend Connection
  extend ApiMethods
  
end
