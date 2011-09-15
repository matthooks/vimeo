require 'rubygems'
require 'httparty'
require 'digest/md5'

require 'net/http/post/multipart'

#require 'active_support'
#require 'active_support/core_ext'

$:.unshift(File.dirname(__FILE__))
require 'vimeo/simple'
require 'vimeo/advanced'

module Vimeo
  
  # try to use ActiveSupport, then yajl/json_gem, then gem json
  def self.parse_json(json_response)
    parser ||= if defined?(ActiveSupport)
      Proc.new {|json| ActiveSupport::JSON.decode(json) }
    else
      begin
        require "json" unless defined?(JSON)
        Proc.new {|json| JSON.parse(json) }
      rescue LoadError => e
        raise LoadError, "You need have installed gem 'json' or require 'yajl/json_gem' before"
      end
    end

    parser.call(json_response)
  end
end