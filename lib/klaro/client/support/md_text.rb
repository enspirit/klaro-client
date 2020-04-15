module Klaro
  class Client
    class MdText

      SHARED_OPTIONS = {
        filter_html: true,
        no_links: false,
        no_styles: true,
        safe_links_only: true,
        with_toc_data: false
      }

      VARIANTS = {
        :summary => Redcarpet::Markdown.new(
          Redcarpet::Render::HTML.new(SHARED_OPTIONS.merge({
            hard_wrap: true,
          }))
        ),
        :details => Redcarpet::Markdown.new(
          Redcarpet::Render::HTML.new(SHARED_OPTIONS.merge({
            hard_wrap: false,
          }))
        )
      }

      def initialize(src, variant)
        @src = src
        @renderer = VARIANTS[variant]
      end

      def to_s
        @src
      end

      def to_html
        @renderer.render(to_s).strip.gsub(/<a href/, '<a target="_blank" href')
      end

    end # class MdText
  end # class Client
end # module Klaro
