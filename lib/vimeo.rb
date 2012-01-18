require 'rubygems'
require 'httparty'
require 'digest/md5'

require 'net/http/post/multipart'

require 'multi_json'

$:.unshift(File.dirname(__FILE__))
require 'vimeo/simple'
require 'vimeo/advanced'

module Vimeo
end
