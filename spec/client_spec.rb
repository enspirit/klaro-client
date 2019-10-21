# frozen_string_literal: true

require 'spec_helper'

module Klaro
  describe Client do
    let(:client) do
      Client.new('https://foobar.klaro.cards')
    end

    describe '#intialize' do
      it 'has attribute request' do
        expect(client.request).to be_a(Client::RequestHandler)
      end
    end

    describe '#login' do
      context 'with valid data' do
        it 'responds with success' do
          stub_auth
          client.login('foobar', 'password')
          response_hash = JSON.parse(response_body)
          expect(client.request.token).to eq("#{response_hash['token_type']} #{response_hash['access_token']}")
        end
      end
      context 'with invalid data' do
        it 'raises a AuthenticationFailed if invalid data' do
          stub_auth(code: 404)
          expect { client.login('foobar', 'password') }.to raise_error(Client::Error::AuthenticationFailed)
        end
      end
    end

    describe '#stories' do
      it 'returns news stories' do
        stub_stories(board: 'news')
        stories = client.stories('news')
        expect(stories.first['description']).to eq('A Foo Bar story title')
      end

      it 'returns board not found' do
        stub_stories(board: 'no_board', code: 404)
        expect { client.stories('no_board') }.to raise_error(Client::Error::NoSuchBoardFound)
      end

      it 'extract images' do
        stub_download_file
        stub_stories(board: 'news')
        client.stories('news').map do |story|
          expect(story).to be_a(Client::Story)
          expect(story.specification).to eql(<<~MD)
            Hello ![Image Label](/s/path/to/image.jpg)
          MD
          folder = Path(Dir.pwd + '/tmp')
          relocated = story.download_and_relocate_images(folder.parent, folder, client)
          expect(relocated).to be_a(Client::Story)
          expect(relocated == story).to be(false)
          expect(relocated.specification).to eql(<<~MD)
            Hello ![Image Label](/tmp/news/15.jpg)
          MD
          expect(Path(Dir.pwd + '/tmp/news/15.jpg').exists?).to be(true)
        end
      end
    end

    describe '#dimensions' do
      let(:dimensions) { JSON.parse File.read('spec/fixtures/dimensions.json') }
      it 'retrieves all dimensions when no params provided' do
        stub_dimensions
        expect(client.dimensions).to eq(dimensions)
      end
      let(:foo_bar_dimension) { dimensions.select{|elm| elm['code']=='foo-bar'}.first}
      it 'retrieves a specific dimension if code provided' do
        stub_dimensions
        expect(client.dimensions(code: 'foo-bar')).to eq(foo_bar_dimension)
      end
    end
  end
end
