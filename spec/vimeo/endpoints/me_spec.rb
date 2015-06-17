require "spec_helper"

describe Vimeo::Endpoints::Me do
  it_behaves_like 'an endpoint', 'me', Vimeo::Entities::Me, false
end
