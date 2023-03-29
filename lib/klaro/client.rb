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

    def absolute_url(url)
      request.base_url + url
    end

    def with_token(*args, &bl)
      request.with_token(*args, &bl)
    end

    def with_project(*args, &bl)
      request.with_project(*args, &bl)
    end

    def login(*args, &bl)
      request.authenticate(*args, &bl)
    end

    def dimension(code_or_id)
      Dimension.dress(request.get("/api/dimensions/#{code_or_id}"), self)
    end

    def dimensions
      Dimensions.dress(request.get('/api/dimensions'), self)
    end

    def board(location_or_id)
      Board.dress(request.get("/api/boards/#{location_or_id}"), self)
    end

    DEFAULT_BOARD_STORIES_OPTIONS = {

    }

    def board_stories(location_or_id, options = {})
      options = DEFAULT_BOARD_STORIES_OPTIONS.merge(options)
      depth = options[:infoDepth] || 'short'
      accept = "application/vnd+klaro.stories.#{depth}+json"
      req = request.with_extra_headers("Accept" => accept)
      Stories.dress(req.get("/api/boards/#{location_or_id}/stories/"), self)
    end

    def story(id_or_identifier)
      Story.dress(request.get("/api/stories/#{id_or_identifier}"), self)
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
