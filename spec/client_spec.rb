# frozen_string_literal: true

require 'spec_helper'

module Klaro
  describe Client do
    let(:client) do
      Klaro::Client.new('https://foobar.klaro.cards')
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
        stub_board_stories(board: 'news')
        stories = client.board_stories('news')
      end

      it 'returns board not found' do
        stub_board_stories(board: 'no_board', code: 404)
        expect { client.board_stories('no_board') }.to raise_error(Client::Error::NoSuchBoardFound)
      end
    end

    describe '#dimension' do
      let(:foo_bar_dimension) { JSON.parse File.read('spec/fixtures/dimension.json') }
      it 'retrieves a specific dimension if code provided' do
        stub_a_dimension('foo-bar')
        got = client.dimension('foo-bar')
        expect(got).to be_a(Klaro::Client::Dimension)
        expect(got.to_h).to eq(symbolize_keys(foo_bar_dimension))
      end
    end

    describe '#board' do
      let(:board) { JSON.parse File.read('spec/fixtures/board.json') }
      it 'retrieves a specific board if location is provided' do
        stub_a_board('default')
        got = client.board('default')
        expect(got).to be_a(Klaro::Client::Board)
        expect(got.to_h).to eq(symbolize_keys(board))
      end
    end

    describe '#dimensions' do
      let(:dimensions) { JSON.parse File.read('spec/fixtures/dimensions.json') }
      it 'retrieves all dimensions when no params provided' do
        stub_dimensions
        got = client.dimensions
        expect(got).to be_a(Klaro::Client::Dimensions)
        expect(got.all?{|d| d.is_a?(Klaro::Client::Dimension) })
      end
    end

    describe "#story" do
      let(:story) { JSON.parse File.read('spec/fixtures/story.json') }
      it 'retrieves a specific board if location is provided' do
        stub_story(1)
        got = client.story(1)
        expect(got).to be_a(Klaro::Client::Story)
        expect(got.to_h).to eq(symbolize_keys(story))
      end
    end

    describe '#upload_image' do
      let(:image_path) { 'spec/fixtures/img.jpg' }
      it 'returns a response with location info' do
        stub_image_upload
        expect(client.upload_image(image_path)).to eq('/s/something?n=img.jpg')
      end
    end
  end
end
