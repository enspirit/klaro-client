module Klaro
  class Client
    class MdText

      SHARED_OPTIONS = {
        unsafe: false,
      }

      def initialize(src, variant, options = {})
        @src = src
        @variant = variant
        @options = SHARED_OPTIONS.merge(options)
      end

      def to_s
        @src
      end

      def render_options
        @options.merge({
          hardbreaks: (@variant == :summary)
        })
      end

      def to_html(options = {})
        Commonmarker.to_html(to_s, options: {
          render: render_options.merge(options)
        }).strip.gsub(/<a href/, '<a target="_blank" href')
      end

    end # class MdText
  end # class Client
end # module Klaro
