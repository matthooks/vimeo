module CreateApiMethod
  
  # Small DSL that creates a method that calls a Vimeo method through the advanced API.
  #
  # @param [String] method The name of the method being created.
  # @param [String] vimeo_method The name of the advanced API Method the function should call.
  # @param [Hash] options Some optional parameters.
  # @option options [Array] :required An array of required parameters.
  # @option options [Array] :optional An array of optional parameters.
  def create_api_method(method, vimeo_method, options={})
    options = { :required => [], :optional => [] }.merge(options)
    
    method = method.to_s
    camelized_method = camelize(method, false)
    
    raise ArgumentError, 'Required parameters must be an array.' unless options[:required].is_a? Array
    raise ArgumentError, 'Optional parameters must be an array.' unless options[:optional].is_a? Array
    
    auth_token = options[:required].delete :auth_token
    
    required = options[:required].map { |r| r.to_s }.join(",")
    optional = options[:optional].map { |o| ":#{o} => nil" }.join(",")
    
    parameters = "(#{required unless required.blank?}#{',' unless required.blank?}options={#{optional}})"
    
    method_string = <<-method

      def #{method}#{parameters}
        raise ArgumentError, 'Options must be a hash.' unless options.is_a? Hash
        
        sig_options = {
          #{ ":oauth_token => @oauth_token," if auth_token}
          :method => "#{vimeo_method}",
          :format => "json"
        }

        #{ options[:required].map { |r| "sig_options.merge! :#{r} => #{r}"}.join("\n") }
        #{ options[:optional].map { |o| "sig_options.merge! :#{o} => options[:#{o}] unless options[:#{o}].nil?" }.join("\n") }
        
        make_request sig_options
      end
      
      alias #{camelized_method} #{method}
      
    method
    
    class_eval method_string
  end
  
  protected
  
  # taken from ActiveSupport-2.3.4, activesupport/lib/active_support/inflector.rb, line 178
  def camelize(lower_case_and_underscored_word, first_letter_in_uppercase = true)
    if first_letter_in_uppercase
      lower_case_and_underscored_word.to_s.gsub(/\/(.?)/) { "::#{$1.upcase}" }.gsub(/(?:^|_)(.)/) { $1.upcase }
    else
      lower_case_and_underscored_word[0..0].downcase + camelize(lower_case_and_underscored_word)[1..-1]
    end
  end
end

module Vimeo
  module Advanced

    class RequestFailed < StandardError; end

    class Base < OAuthClient::Client
      http_method :post
      site 'http://vimeo.com'

      # schemes are [:body, :query_string, :header]
      scheme :header
      request_scheme :query_string
      extend CreateApiMethod

      # Requires your API key and secret phrase.
      # The API key and secret are prepended to every request.
      def initialize(api_key, secret, options = {})
        @oauth_token = options[:token]
        super(options.merge(:consumer_key => api_key, :consumer_secret => secret))
      end
      
      private

      def make_request(options)
        result = json.post "/api/rest/v2", (options || {})
        validate_response! result
        result
      end

      create_api_method :check_access_token,
                        "vimeo.oauth.checkAccessToken"
      
      # Raises an exception if the response does contain a +stat+ different from "ok"
      def validate_response!(response)
        raise "empty response" unless response
        
        status = response["stat"]
                
        if status and status != "ok"
          error = response["err"]
          if error
            raise RequestFailed, "#{error["code"]}: #{error["msg"]}, explanation: #{error["expl"]}"
          else
            raise RequestFailed, "Error: #{status}, no error message"
          end
        end
      end

    end # Base

  end # Advanced
end # Vimeo