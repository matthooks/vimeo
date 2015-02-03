module Vimeo
  class Collection
    def initialize items, options = {}
      @items = items
    end

    def [](i)
      @items[i]
    end

    def next_page
    end

    def previous_page
    end

    def num_pages
    end

    private
    # delegate any missing methods to @items
    def method_missing(meth, *args, &block)
      @items.__send__(meth, *args, &block)
    end
  end
end