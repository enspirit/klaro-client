module Klaro
  class Client
    class RequestHandler

      attr_reader :base_url, :token

      def initialize(url)
        @base_url = url
      end

      def authenticate(user, password)
        @token = get_token Http
        .headers({
          'Content-Type' => 'application/json'
        })
        .post("#{base_url}/api/auth/tokens/", payload(user, password))
      end

      def get(endpoint, raw = false)
        url = "#{base_url}#{endpoint}"
        info("GET `#{url}`")
        response = http.get(url, ssl_context: http_ctx)
        raise Error::NoSuchBoardFound if response.status >= 300 || response.status <200

        raw ? response.to_s : JSON.parse(response.to_s)
      end

    private

      def get_token(response)
        raise Error::AuthenticationFailed if response.status >= 300 || response.status <200

        response = JSON.parse(response.body)
        "#{response['token_type']} #{response['access_token']}"
      end

      def payload(user, password)
        { json: {
            grant_type: "client_credentials",
            client_id: user,
            client_secret: password
          },
          ssl_context: http_ctx
        }
      end

      def http_ctx
        OpenSSL::SSL::SSLContext.new
      end

      def http
        Http.headers(
          {
            Authorization: @token
          }
        )
      end

      def info(msg)
        puts msg
      end
      alias error info
    end
  end
end
