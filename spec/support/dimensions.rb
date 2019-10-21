require 'webmock/rspec'

def stub_dimensions
  endpoint = 'https://foobar.klaro.cards/api/dimensions'
  stub_request(:get, endpoint)
    .with(
      headers: {
        'Connection' => 'close',
        'Host' => 'foobar.klaro.cards',
        'User-Agent' => 'http.rb/4.1.1'
      }
    )
    .to_return(status: 200, body: File.read('spec/fixtures/dimensions.json'))
end

def stub_a_dimension(code)
  endpoint = "https://foobar.klaro.cards/api/dimensions/#{code}"
  stub_request(:get, endpoint)
    .with(
      headers: {
        'Connection' => 'close',
        'Host' => 'foobar.klaro.cards',
        'User-Agent' => 'http.rb/4.1.1'
      }
    )
    .to_return(status: 200, body: File.read('spec/fixtures/dimension.json'))
end
