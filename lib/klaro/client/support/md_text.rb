module Klaro
  class Client
    class MdText

      RENDERER = Redcarpet::Render::HTML.new({
        filter_html: true,
        hard_wrap: true,
        no_links: false,
        no_styles: true,
        safe_links_only: true,
        with_toc_data: false
      })

      MARKDOWN = Redcarpet::Markdown.new(RENDERER)

      def initialize(src)
        @src = src
      end

      def to_s
        @src
      end

      def to_html
        MARKDOWN.render(to_s).strip
      end

    end # class MdText
  end # class Client
end # module Klaro
