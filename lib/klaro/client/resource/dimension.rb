module Klaro
  class Client
    class Dimension < Resource

      def values
        @values ||= super
          .map{|v| DimensionValue.dress(v) }
          .sort{|v1,v2| v1.ordering <=> v2.ordering }
      end

    end # class Dimension
  end # class Client
end # module Klaro
