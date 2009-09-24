require 'rubygems'
require 'test/unit'

gem 'thoughtbot-shoulda', ">= 2.10.2"
gem 'fakeweb', ">= 1.2.6"

require 'shoulda'
require 'fakeweb'
require 'httparty'
require 'Crack'

FakeWeb.allow_net_connect = false

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'vimeo'

class Test::Unit::TestCase
end

def fixture_file(filename)
  return '' if filename == ''
  file_path = File.expand_path(File.dirname(__FILE__) + '/fixtures/' + filename)
  File.read(file_path)
end

def vimeo_url(url)
  "http://vimeo.com/api/v2#{url}"
end

def stub_get(url, filename, status=nil)
  # FIXME: We have to specify content type, otherwise HTTParty will not parse the 
  # body correctly. Is there any way we can get around this? Or is this a limitation
  # of using FakeWeb?
  options = { :body => fixture_file(filename), :content_type => 'application/json' }
  options.merge!({:status => status}) unless status.nil?

  FakeWeb.register_uri(:get, vimeo_url(url), options)
end

def stub_post(url, filename)
  FakeWeb.register_uri(:post, vimeo_url(url), :body => fixture_file(filename))
end