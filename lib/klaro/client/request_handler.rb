module Klaro
  class Client
    class RequestHandler
      Http = HTTP

      attr_reader :base_url, :token

      def initialize(url)
        @base_url = url.gsub(/\/api\/?$/, "")
        @token = nil
        @subdomain = nil
        @workspace = nil
        @caching_options = nil
      end

      def authenticated?
        not(@token.nil?)
      end

      def with_token(token_type, access_token)
        @token = "#{token_type} #{access_token}"
        self
      end

      def with_project(subdomain)
        @subdomain = subdomain
        self
      end

      def with_workspace(workspace)
        @workspace = workspace
        self
      end

      def with_cache(caching_options)
        @caching_options = caching_options
        self
      end

      def authenticate(user, password, workspace = nil)
        @workspace = workspace
        @token = get_token(
          Http
            .headers({
              'Content-Type' => 'application/json'
            })
            .post("#{base_url}/api/auth/tokens/", payload(user, password))
        )
      end

      def get(endpoint, raw = false)
        url = "#{base_url}#{endpoint}"
        info("GET `#{url}`")
        response = get_in_cache(url) do
          res = http.get(url, ssl_context: http_ctx)
          raise Error::NoSuchBoardFound unless res.status == 200
          res.to_s
        end
        raw ? response.to_s : JSON.parse(response.to_s)
      end

      def get_in_cache(url, &bl)
        return bl.call unless @caching_options

        sha = Digest::SHA1.hexdigest(url)
        file = @caching_options[:path]/sha
        if file.file?
          file.read
        else
          str = bl.call
          file.parent.mkdir_p
          file.write(str)
          str
        end
      end

      def post(endpoint, body)
        url = "#{base_url}#{endpoint}"
        info("POST `#{url}`")
        http.post(url, body.merge(ssl_context: http_ctx))
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

      def http(headers = {})
        Http.headers(http_headers.merge(headers))
      end

      def http_headers
        hs = {
          "Authorization" => @token,
          "Content-Type" => "application/json"
        }
        hs['Klaro-Project-Subdomain'] = @subdomain if @subdomain
        hs['X-Klaro-ViewAs'] = @workspace if @workspace
        hs
      end

      def info(msg)
        puts msg
      end
      alias error info
    end
  end
end
