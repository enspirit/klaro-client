module Klaro
  class Client
    class Resource < OpenStruct

      class << self
        alias :dress :new
      end

    end # class Resource
    class Collection
      include Enumerable

      def initialize(items)
        @items = items.map{|i| self.class.dress_one(i) }
      end

      def each(*args, &bl)
        @items.each(*args, &bl)
      end

      class << self
        alias :dress :new

        def item(clazz)
          @item_class = clazz
        end

        def dress_one(item)
          @item_class.dress(item)
        end
      end

    end
  end # class Client
end # module Klaro
require_relative 'resource/story'
require_relative 'resource/dimension'
require_relative 'resource/dimensions'
