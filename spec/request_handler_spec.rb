require 'spec_helper'

module Klaro
  class Client
    describe RequestHandler do
      let(:request) { RequestHandler.new('https://foobar.klaro.cards') }
      describe 'initialize' do
        it 'saves base_url' do
          expect(request.base_url).to match(/https:\/\/[\S]+.klaro.cards/)
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

      describe '#get' do
        let(:endpoint) { '/boards/news/stories/' }
        it 'gets data from endpoint' do
           stub_request(:get, "https://foobar.klaro.cards/boards/news/stories/")
            .with(
               headers: {
                'Connection'=>'close',
                'Host'=>'foobar.klaro.cards',
                'User-Agent'=>'http.rb/4.1.1'
               })
            .to_return(status: 200, body: stories_data)
          request.get(endpoint)
        end
      end
    end
  end
end
