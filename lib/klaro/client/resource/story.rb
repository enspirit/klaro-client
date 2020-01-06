module Klaro
  class Client
    class Story < Resource

      def download_and_relocate_attachments(root_path, target_folder, client)
        as = self.attachments.map do |attachment|
          url = attachment["url"]
          url += "?n=" + URI.encode_www_form_component(attachment["filename"]) unless url =~ /\?n=/
          path = handle_image(url, root_path, target_folder, client)
          attachment.merge("url" => path)
        end
        self.class.new(self.to_h.merge(
          attachments: as
        ))
      rescue => ex
        puts ex.message
        puts ex.backtrace.join("\n")
        raise
      end

      def download_and_relocate_images(root_path, target_folder, client)
        spec = self.specification.gsub(%r{!\[([^\]]*)\]\(([^\)]*)\)}) do
          m = Regexp.last_match
          label, url = m[1], m[2]
          image_relative_path = handle_image(url, root_path, target_folder, client)
          "![#{label}](#{image_relative_path})"
        end
        self.class.new(self.to_h.merge(
          specification: spec
        ))
      end

    private

      def handle_image(url, root_path, folder, client)
        image_path = get_image_path(url, folder)
        download_image(url, image_path, client) unless image_path.exists?
        '/' + image_path.relative_to(root_path).to_s
      end

      def get_image_path(url, folder)
        file_name = URI.parse(url).query.gsub('n=', '')
        file_name = URI.decode_www_form_component(file_name)
        folder/"#{self['card-kind']}/#{identifier}/#{file_name}"
      end

      def download_image(url, target_file, client)
        target_file.parent.mkdir_p unless target_file.parent.exists?
        img = client.request.get("#{url}", true)
        target_file.write(img)
      end

    end
  end
end
