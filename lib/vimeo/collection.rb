module Vimeo
  class Collection
    include Vimeo::Helpers

    def initialize client, items, klass, options = {}
      @client, @items, @klass, @options = client, items, klass, options
    end

    def next_page
      page = @options[:pages][:next]
      false if page.nil?
      perform_get_with_object(page, {}, @klass)
    end

    def previous_page
      page = @options[:pages][:previous]
      perform_get_with_object(page, {}, @klass)
    end

    private
    # delegate any missing methods to @items
    def method_missing(meth, *args, &block)
      @items.__send__(meth, *args, &block)
    end
  end
end