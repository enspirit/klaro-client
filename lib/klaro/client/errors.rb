module Klaro
  class Client
    class Error < StandardError
      class NoSuchBoardFound < Error
      end
      class AuthenticationFailed < Error
      end
    end
  end
end
