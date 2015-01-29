VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/cassettes"
  config.hook_into :webmock
  config.filter_sensitive_data '<ACCESS_TOKEN>' do |interaction|
    interaction.request.headers['Authorization'].first
  end
end

RSpec.configure do |c|
  c.around(:each, :vcr) do |example|
    name = example.metadata[:full_description]
    VCR.use_cassette(name) { example.call }
  end
end
