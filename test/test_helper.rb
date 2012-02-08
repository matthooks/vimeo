require 'rubygems'
require 'test/unit'

gem 'shoulda', ">= 2.10.2"
gem 'fakeweb', ">= 1.2.6"
gem 'crack', ">= 0.1.4"
gem 'mocha', ">= 0.9.8"

require 'shoulda'
require 'fakeweb'
require 'Crack'
require 'mocha'
require 'ruby-prof'

FakeWeb.allow_net_connect = false

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'vimeo'

class Test::Unit::TestCase
  def setup
    FakeWeb.clean_registry
  end
end

def fixture_file(filename)
  return '' if filename == ''
  file_path = File.expand_path(File.dirname(__FILE__) + '/fixtures/' + filename)
  File.read(file_path)
end

def vimeo_base_url(url = "/")
  "http://vimeo.com#{url}"
end

def vimeo_url(url = "")
  vimeo_base_url("/api/v2#{url}")
end

def advanced_vimeo_url(url = "")
  vimeo_base_url("/api/rest/v2#{url}")
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
  FakeWeb.register_uri(:post, advanced_vimeo_url, :body => fixture_file(filename), :content_type => 'application/json')
end

def stub_custom_get(url, filename)
  FakeWeb.register_uri(:get, vimeo_base_url(url), :body => fixture_file(filename), :content_type => 'application/json')
end

def stub_custom_post(url, filename)
  FakeWeb.register_uri(:post, vimeo_base_url(url), :body => fixture_file(filename), :content_type => 'application/json')
end
