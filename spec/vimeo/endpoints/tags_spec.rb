require "spec_helper"

describe Vimeo::Endpoints::Tags do
  it_behaves_like 'an endpoint', 'tag', Vimeo::Entities::Tag, false, 'comedy'
end
