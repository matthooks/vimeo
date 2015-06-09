module Vimeo
  ##
  # == Description
  # Collection provides an abstraction of the Vimeo API implementation of pagination.
  # Instead of of calling the api with the page option set to page 2 you can instead
  # use a set of helper methods to navigate between pages.
  # see pagination under docs/ for more information
  class Collection
    include Vimeo::Helpers

    ##
    # Stores the set of items in the current page
    attr_accessor :items

    ##
    # The current page number
    attr_accessor :current_page

    # :nodoc:
    def initialize client, items, klass, options = {}
      @client, @items, @klass, @options = client, items, klass, options
      @current_page = options.fetch(:page)
    end

    ##
    # Go to to the next page
    def next_page
      page = @options[:pages][:next]
      false if page.nil?
      update_collection_to_page page
    end

    ##
    # Go to the first page
    def first_page
      page = @options[:pages][:first]
      update_collection_to_page page
    end

    ##
    # Go to the last page
    def last_page
      page = @options[:pages][:last]
      update_collection_to_page page
    end

    ##
    # Go to the previous page
    def previous_page
      page = @options[:pages][:previous]
      update_collection_to_page page
    end

    protected

    def update_collection_to_page page
      options_without_page = @options.tap { |i| i.delete(:page) }
      new_collection = perform_get_with_object(page, options_without_page, @klass)
      @current_page = new_collection.current_page
      @items = new_collection.items
    end

    private
    # delegate any missing methods to @items
    # :nodoc:
    def method_missing(method, *args, &block)
      @items.__send__(method, *args, &block)
    end
  end
end