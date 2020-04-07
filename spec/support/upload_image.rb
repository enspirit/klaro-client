# frozen_string_literal: true

require 'webmock/rspec'

def stub_image_upload
  stub_request(:post, 'https://foobar.klaro.cards/s/')
    .to_return(status: 204, headers: {
      location: 'https://foobar.klaro.cards/s/something?n=img.jpg'
    })
end
