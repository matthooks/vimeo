require "spec_helper"

describe Vimeo::Endpoints::Groups do
  it_behaves_like 'an endpoint', 'groups', Vimeo::Entities::Group, true
  it_behaves_like 'an endpoint', 'group', Vimeo::Entities::Group, false, 1
end
