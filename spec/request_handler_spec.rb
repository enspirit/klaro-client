require 'spec_helper'

module Klaro
  class Client
    describe RequestHandler do
      let(:request) { RequestHandler.new('https://foobar.klaro.cards') }

      describe 'initialize' do
        it 'saves base_url' do
          expect(request.base_url).to match(/https:\/\/[\S]+.klaro.cards/)
        end
        it 'strips any /api/ suffix' do
          r = RequestHandler.new('https://foobar.klaro.cards/api')
          expect(r.base_url).to eql("https://foobar.klaro.cards")
          r2 = RequestHandler.new('https://foobar.klaro.cards/api/')
          expect(r2.base_url).to eql("https://foobar.klaro.cards")
        end
      end

      describe '#authenticate' do
        it 'request a token' do
          stub_auth
          request.authenticate('foobar', 'password')
          response_hash = JSON.parse(response_body)
          expect(request.token).to eq("#{response_hash['token_type']} #{response_hash['access_token']}")
        end
      end

      describe '#with_token' do
        it 'allows setting a token to use' do
          got = request.with_token('OAuth2', 'foobar')
          expect(got).to be(request)
          expect(got.authenticated?).to eql(true)
        end
      end

      describe '#get' do
        let(:endpoint) { '/boards/news/stories/' }
        it 'gets data from endpoint' do
           stub_request(:get, "https://foobar.klaro.cards/boards/news/stories/")
            .with(
               headers: simple_header
            )
            .to_return(status: 200, body: stories)
          request.get(endpoint)
        end
      end
    end
  end
end
