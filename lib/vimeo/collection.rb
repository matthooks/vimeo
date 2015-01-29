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

    protected
  end
end