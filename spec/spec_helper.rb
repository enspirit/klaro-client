# frozen_string_literal: true

require 'webmock/rspec'
require 'klaro/client'
require 'support/dimensions.rb'

def stub_auth(body: response_body, code: 200)
  stub_request(:post, 'https://foobar.klaro.cards/api/auth/tokens/')
    .with(
      body: auth_body,
      headers: auth_header
    )
    .to_return(status: code, body: body)
end

def auth_header
  simple_header.merge!(
    'Content-Type' => 'application/json'
  )
end

def simple_header
  {
    'Connection' => 'close',
    'Host' => 'foobar.klaro.cards',
    'User-Agent' => 'http.rb/4.1.1'
  }
end

def response_body
  File.read('spec/fixtures/auth_response.json')
end

def stories_data
  File.read('spec/fixtures/stories_data.json')
end

def auth_body
  '{"grant_type":"client_credentials","client_id":"foobar","client_secret":"password"}'
end

def stub_stories(board:, code: 200)
  stub_request(:get, "https://foobar.klaro.cards/api/boards/#{board}/stories/")
    .with(
      headers: simple_header
    )
    .to_return(status: code, body: File.read('spec/fixtures/stories_data.json'))
  stub_request(:get, 'https://foobar.klaro.cards/api/stories/1')
    .with(
      headers: simple_header
    )
    .to_return(status: 200, body: File.read('spec/fixtures/story_data.json'))
end

def stub_download_file
  stub_request(:get, 'https://foobar.klaro.cards/s/path/to/image.jpg')
    .with(
      headers: {
        'Connection' => 'close',
        'Host' => 'foobar.klaro.cards',
        'User-Agent' => 'http.rb/4.1.1'
      }
    )
    .to_return(status: 200, body: File.read('spec/fixtures/img.jpg'))
end
