require 'webmock/rspec'

def stub_a_board(location)
  endpoint = "https://foobar.klaro.cards/api/boards/#{location}"
  stub_request(:get, endpoint)
    .with(
      headers: simple_header
    )
    .to_return(status: 200, body: File.read('spec/fixtures/board.json'))
end

def stub_board_stories(board:, code: 200)
  stub_request(:get, "https://foobar.klaro.cards/api/boards/#{board}/stories/")
    .with(
      headers: simple_header
    )
    .to_return(status: code, body: File.read('spec/fixtures/stories.json'))
end
