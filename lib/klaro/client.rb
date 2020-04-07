require 'http'
require 'path'

module Klaro
  class Client
    attr_reader :request

    def initialize(base_url)
      @request = RequestHandler.new(base_url)
    end

    def with_token(*args, &bl)
      request.with_token(*args, &bl)
    end

    def login(*args, &bl)
      request.authenticate(*args, &bl)
    end

    def dimension(code_or_id)
      request.get("/api/dimensions/#{code_or_id}")
    end

    def dimensions
      request.get('/api/dimensions')
    end

    def stories(board)
      stories_list = request.get("/api/boards/#{board}/stories/")
      stories_list.map do |s|
        Story.new(request.get("/api/stories/#{s['id']}"))
      end
    end

    def upload_image(image_path)
      body = {
        form: {
          file: HTTP::FormData::File.new(image_path)
        }
      }
      response = request.post('/s/', body)
      URI(response['location']).request_uri
    end
  end
end
require_relative 'client/version'
require_relative 'client/errors'
require_relative 'client/request_handler'
require_relative 'client/resource'
