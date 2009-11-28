require 'rubygems'
require 'httparty'
require 'digest/md5'

$:.unshift(File.dirname(__FILE__))
require 'oauth_client'
require 'vimeo/simple'
require 'vimeo/advanced'

module Vimeo
end