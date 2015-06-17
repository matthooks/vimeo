require "spec_helper"

describe Vimeo::Endpoints::Categories do
  it_behaves_like 'an endpoint', 'categories', Vimeo::Entities::Category, true
  it_behaves_like 'an endpoint', 'category', Vimeo::Entities::Category, false, 'animation'
end
