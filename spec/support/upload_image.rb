# frozen_string_literal: true

require 'webmock/rspec'

def stub_image_upload
  stub_request(:post, 'https://foobar.klaro.cards/s/')
    .with(
      body: { 'file' => '#<File:0x00007f9c9da48bc0>', 'filename' => 'img.jpg', 'name' => 'file' },
      headers: {
        'Connection' => 'close',
        'Content-Type' => 'application/x-www-form-urlencoded',
        'Host' => 'foobar.klaro.cards',
        'User-Agent' => 'http.rb/4.1.1'
      }
    )
    .to_return(status: 204, body: '', headers: {
                 location: 'http:foobar.klaro.cards/s/something?n=img.jpg'
               })
end
