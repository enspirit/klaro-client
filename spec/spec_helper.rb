# frozen_string_literal: true

require 'webmock/rspec'
require 'klaro/client'
require 'support/dimensions.rb'
require 'support/boards.rb'
require 'support/stories.rb'
require 'support/upload_image'

def symbolize_keys(*args, &bl)
  Klaro::Client::Resource.symbolize_keys(*args, &bl)
end

def stub_auth(body: response_body, code: 200)
  stub_request(:post, 'https://foobar.klaro.cards/api/auth/tokens/')
    .with(
      body: auth_body,
      headers: auth_header
    )
    .to_return(status: code, body: body)
end

def auth_header
  simple_header
end

def simple_header
  {
    'Content-Type' => 'application/json',
    'Connection' => 'close',
    'Host' => 'foobar.klaro.cards'
  }
end

def response_body
  File.read('spec/fixtures/auth_response.json')
end

def stories
  File.read('spec/fixtures/stories.json')
end

def auth_body
  '{"grant_type":"client_credentials","client_id":"foobar","client_secret":"password"}'
end

def stub_download_file
  stub_request(:get, 'https://foobar.klaro.cards/s/somehash.jpeg?n=foobar.jpg')
    .with(
      headers: simple_header
    )
    .to_return(status: 200, body: File.read('spec/fixtures/img.jpg'))
end
