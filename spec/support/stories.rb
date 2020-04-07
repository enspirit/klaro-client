require 'webmock/rspec'

def stub_story(id)
  stub_request(:get, "https://foobar.klaro.cards/api/stories/#{id}")
    .with(
      headers: simple_header
    )
    .to_return(status: 200, body: File.read('spec/fixtures/story.json'))
end
