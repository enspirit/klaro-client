require 'http'
require 'path'
require 'redcarpet'
require 'i18n'

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
      Dimension.dress(request.get("/api/dimensions/#{code_or_id}"))
    end

    def dimensions
      Dimensions.dress(request.get('/api/dimensions'))
    end

    def board(location_or_id)
      Board.dress(request.get("/api/boards/#{location_or_id}"))
    end

    def board_stories(location_or_id)
      Stories.dress(request.get("/api/boards/#{location_or_id}/stories/"))
    end

    def story(id_or_identifier)
      Story.dress(request.get("/api/stories/#{id_or_identifier}"))
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
require_relative 'client/support/md_text'
require_relative 'client/request_handler'
require_relative 'client/resource'
