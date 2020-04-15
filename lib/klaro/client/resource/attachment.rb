module Klaro
  class Client
    class Attachment < Resource

      def absUrl
        @client.absolute_url(self.url)
      end

      def absThumbnailUrl
        @client.absolute_url(self.thumbnailUrl)
      end

    end # class Attachment
  end # class Client
end # module Klaro
