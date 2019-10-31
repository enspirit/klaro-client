module Klaro
  class Client
    class Story < Resource

      def download_and_relocate_images(root_path, folder, client)
        spec = handle_images(specification) do |url|
          handle_image(url, root_path, folder, client)
        end
        get_new_story(spec)
      end

    private

      def get_new_story(spec)
        story = self.class.new(self.to_h)
        story.specification = spec
        story
      end

      def handle_images(specification, &block)
        specification.gsub(%r{!\[([^\]]*)\]\(([^\)]*)\)}) do
          m = Regexp.last_match
          label, url = m[1], m[2]
          image_relative_path = block.call(url)
          "![#{label}](#{image_relative_path})"
        end
      end

      def handle_image(url, root_path, folder, client)
        image_path = get_image_path(url, folder)
        download_image(url, image_path, client) unless image_path.exists?
        '/' + image_path.relative_to(root_path).to_s
      end

      def get_image_path(url, folder)
        file_name = URI.parse(url).query.gsub('n=', '')
        folder/"#{self['card-kind']}/#{identifier}/#{file_name}"
      end

      def download_image(url, image_path, client)
        image_path.parent.mkdir_p unless image_path.parent.exists?
        img = client.request.get("#{url}", true)
        image_path.write(img)
      end

    end
  end
end
