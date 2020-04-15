module Klaro
  class Client
    class Resource < OpenStruct

      def initialize(data, client)
        super(data)
        @client = client
      end

      class << self

        def symbolize_keys(data)
          Hash[data.each_pair.map{|k,v|
            [k.to_sym, v]
          }]
        end

        def dress(data, client)
          new(symbolize_keys(data), client)
        end

      end # class << self

    end # class Resource
    class Collection
      include Enumerable

      def initialize(items, client)
        @items = items.map{|i| self.class.dress_one(i) }
        @client = client
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
          @item_class.dress(item, @client)
        end
      end

    end
  end # class Client
end # module Klaro
require_relative 'resource/story'
require_relative 'resource/attachment'
require_relative 'resource/stories'
require_relative 'resource/dimension'
require_relative 'resource/dimension_value'
require_relative 'resource/dimensions'
require_relative 'resource/board'
