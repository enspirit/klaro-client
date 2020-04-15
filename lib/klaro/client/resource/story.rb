module Klaro
  class Client
    class Story < Resource

      def title
        @title ||= MdText.new(self.description.split("\n").first, :summary)
      end

      def summary
        @summary ||= MdText.new(self.description.split("\n")[1..-1].join("\n"), :summary)
      end

      def specification
        @specification ||= MdText.new(super, :details)
      end
      alias :details :specification

      def attachments
        @attachments || super.map{|a| Attachment.dress(a, @client) }
      end

      def cover_attachment(force = false)
        got = (self.attachments || []).find{|a| a[:isCover] }
        got = (self.attachments || []).first if got.nil? and force
        got
      end

      def to_url(with_identifier = true)
        I18n.config.available_locales = [:en, :fr]
        url = I18n.transliterate(title.to_s)
        url = url.downcase.gsub(/[^\w]+/,"-").gsub(/^[-]+|[-]+$/,"")
        url = "#{self.identifier}-#{url}" if with_identifier
        url
      end

      def download_and_relocate_attachments(root_path, target_folder, client)
        as = self.attachments.map do |attachment|
          url = attachment.url
          url += "?n=" + URI.encode_www_form_component(attachment.filename) unless url =~ /\?n=/
          path = handle_image(url, root_path, target_folder, client)
          attachment.merge(url => path)
        end
        self.class.dress(self.to_h.merge(
          attachments: as
        ), @client)
      end

      def download_and_relocate_images(root_path, target_folder, client)
        spec = self.specification.to_s.gsub(%r{!\[([^\]]*)\]\(([^\)]*)\)}) do
          m = Regexp.last_match
          label, url = m[1], m[2]
          image_relative_path = handle_image(url, root_path, target_folder, client)
          "![#{label}](#{image_relative_path})"
        end
        self.class.dress(self.to_h.merge(
          specification: spec
        ), @client)
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
