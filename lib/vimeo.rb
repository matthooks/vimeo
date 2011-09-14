require 'rubygems'
require 'httparty'
require 'digest/md5'

require 'net/http/post/multipart'

require 'active_support'
require 'active_support/core_ext'

$:.unshift(File.dirname(__FILE__))
require 'vimeo/simple'
require 'vimeo/advanced'

module Vimeo
end