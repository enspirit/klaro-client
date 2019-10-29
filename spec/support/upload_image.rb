# frozen_string_literal: true

require 'webmock/rspec'

def stub_image_upload
  stub_request(:post, 'https://foobar.klaro.cards/s/')
    .with(
      headers: {
        'Connection' => 'close',
        "Content-Type" => %r|\Amultipart/form-data|,
        'Host' => 'foobar.klaro.cards',
        'User-Agent' => 'http.rb/4.1.1'
      }
    )
    .to_return(status: 204, headers: {
                 location: 'https://foobar.klaro.cards/s/something?n=img.jpg'
               })
end
