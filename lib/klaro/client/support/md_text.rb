module Klaro
  class Client
    class MdText

      SHARED_OPTIONS = {
        unsafe: false,
      }

      def initialize(src, variant)
        @src = src
        @variant = variant
      end

      def to_s
        @src
      end

      def render_options
        SHARED_OPTIONS.merge({
          hardbreaks: (@variant == :summary)
        })
      end

      def to_html
        Commonmarker.to_html(to_s, options: {
          render: render_options
        }).strip.gsub(/<a href/, '<a target="_blank" href')
      end

    end # class MdText
  end # class Client
end # module Klaro
