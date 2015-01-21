# rspec extensions
require 'rspec/its'
require "vcr"
require "webmock"

# support files
require "support/vcr"

# lib/
require "vimeo"

# This is the Vimeo API access token used to authenticate requests their the API.
# Most requests should already be recorded with VCR so it shouldn't be
# nessesary to change this value. If there is a request not recorded in
# VCR then edit this to the access token given by Vimeo.
$vimeo_access_token = 'ah'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end
