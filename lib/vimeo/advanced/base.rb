module CreateApiMethod
  
  # Small DSL that creates a method that calls a Vimeo method through the advanced API.
  #
  # @param [String] method The name of the method being created.
  # @param [String] vimeo_method The name of the advanced API Method the function should call.
  # @param [Hash] options Some optional parameters.
  # @option options [Array] :required An array of required parameters.
  # @option options [Array] :optional An array of optional parameters.
  # @option options [Array] :unsigned An array of required parameters that should not be included in the api_sig.
  def create_api_method(method, vimeo_method, options={})
    options = { :required => [], :optional => [], :unsigned => [] }.merge(options)
    
    raise ArgumentError, 'Required parameters must be an array.' unless options[:required].is_a? Array
    raise ArgumentError, 'Optional parameters must be an array.' unless options[:optional].is_a? Array
    raise ArgumentError, 'Unsigned parameters must be an array.' unless options[:optional].is_a? Array
    
    required = (options[:required] + options[:unsigned]).map { |r| r.to_s }.join(",")
    required_hash = options[:required].map { |r| ":#{r} => #{r}" }.join(",")
    optional_hash = options[:optional].map { |o| ":#{o} => nil" }.join(",")
    unsigned_hash = options[:unsigned].map { |u| ":#{u} => #{u}" }.join(",")
    
    parameters = "(#{required unless required.blank?}#{',' unless required.blank?}options={#{optional_hash}})"
    
    method_string = <<-method

      def #{method}#{parameters}
        raise ArgumentError, 'Options must be a hash.' unless options.is_a? Hash
        
        sig_options = {
          :method => "#{vimeo_method}",
          :format => "json"
        }

        #{ options[:required].map { |r| "sig_options.merge! :#{r} => #{r}"}.join("\n") }
        #{ options[:optional].map { |o| "sig_options.merge! :#{o} => options[:#{o}] unless options[:#{o}].nil?" }.join("\n") }
        
        make_request sig_options#{ ", :unsigned => {" + unsigned_hash + "}" unless options[:unsigned].empty? }
      end
      
    method
    
    class_eval method_string
  end

end

module Vimeo
  module Advanced

    class Base
      include HTTParty
      base_uri 'vimeo.com'
      extend CreateApiMethod

      # TODO: Pass an auth token, if you've already got one
      # TODO: implement format_options
      # Requires your API key and secret phrase.
      # The API key and secret are prepended to every request.
      def initialize(api_key, secret, format_options={})
        @auth = { :api_key => api_key }
        @secret = secret
      end
      
      # Generates a link that allows a user to authorize
      # your web application to use the advanced API
      def web_login_link(perms)
        api_sig = generate_api_sig :perms => perms
        "http://vimeo.com/services/auth/?api_key=#{@auth[:api_key]}&perms=#{perms}&api_sig=#{api_sig}"
      end
      
      # Generates a link that allows a user to authorize
      # your desktop application to use the advanced API
      def desktop_login_link(perms, frob)
        api_sig = generate_api_sig :frob => frob, :perms => perms
        "http://vimeo.com/services/auth/?api_key=#{@auth[:api_key]}&perms=#{perms}&frob=#{frob}&api_sig=#{api_sig}"
      end
      
      private

      def make_request(sig_options, options={})
        options = { :unsigned => [] }.merge(options)
        unsigned = options[:unsigned]

        api_sig = generate_api_sig sig_options
        self.class.post "/api/rest/v2", :query => query(sig_options, api_sig), :body => unsigned
      end

      # Generates a MD5 hashed API signature for Advanced API requests
      def generate_api_sig(options={})
        # Every request requires the api_key parameter
        options.merge! @auth
        # Keys must be sorted alphabetically
        api_sig = options.sort { |a, b| a.to_s <=> b.to_s }.join
        Digest::MD5.hexdigest("#{@secret}#{api_sig}")
      end
      
      def query(sig_options, api_sig)
        sig_options.merge :api_key => @auth[:api_key], :api_sig => api_sig
      end

    end # Base

  end # Advanced
end # Vimeo