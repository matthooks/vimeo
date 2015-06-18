require "spec_helper"

describe Vimeo::Endpoints::Channels do
  it_behaves_like 'an endpoint', 'channels', Vimeo::Entities::Channel, true
  it_behaves_like 'an endpoint', 'channel', Vimeo::Entities::Channel, false, 'staffpicks'
end
