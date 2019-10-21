require 'http'
require 'path'

module Klaro
  class Client
    attr_reader :request

    def initialize(base_url)
      @request = RequestHandler.new(base_url)
    end

    def login(user, password)
      request.authenticate(user, password)
    end

    def stories(board)
      stories_list = request.get("/api/boards/#{board}/stories/")
      stories_list.map do |s|
        Story.new(request.get("/api/stories/#{s['id']}"))
      end
    end

    def dimensions(code: nil)
      return request.get('/api/dimensions') unless code
      request.get('/api/dimensions').select{|dim| dim['code'] == code}.first
    end
  end
end
require_relative 'client/errors'
require_relative 'client/request_handler'
require_relative 'client/resource'
