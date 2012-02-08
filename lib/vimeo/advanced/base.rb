require 'oauth'

module CreateApiMethod

  # Creates a method that calls a Vimeo Method through the Advanced API.
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

    required = options[:required].map { |r| r.to_s }.join(",")
    optional = options[:optional].map { |o| ":#{o} => nil" }.join(",")
    authorized = options.fetch(:authorized, true)

    parameters = "(#{required unless required.empty?}#{',' unless required.empty?}options={#{optional}})"

    method_string = <<-method

      def #{method}#{parameters}
        raise ArgumentError, 'Options must be a hash.' unless options.is_a? Hash

        sig_options = {
          :method => "#{vimeo_method}",
          :format => "json"
        }

        #{ options[:required].map { |r| "sig_options.merge! :#{r} => #{r}"}.join("\n") }
        #{ options[:optional].map { |o| "sig_options.merge! :#{o} => options[:#{o}] unless options[:#{o}].nil?" }.join("\n") }

        make_request sig_options, #{authorized ? "true" : "false"}
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

    class Base
      extend CreateApiMethod

      ENDPOINT = "http://vimeo.com/api/rest/v2"

      def initialize(consumer_key, consumer_secret, options = {})
        @oauth_consumer = OAuth::Consumer.new(consumer_key, consumer_secret, :site => 'http://vimeo.com', :http_method => :get, :scheme => :header)
        unless options[:token].nil? && options[:secret].nil?
          @access_token = OAuth::AccessToken.new(@oauth_consumer, options[:token], options[:secret])
        end
      end

      def authorize_url(permission = "delete")
        get_request_token.authorize_url :permission => permission
      end

      def get_request_token
        @request_token ||= @oauth_consumer.get_request_token :scheme => :header
      end

      def get_access_token(oauth_token=nil, oauth_secret=nil, oauth_verifier=nil)
        @access_token ||= OAuth::RequestToken.new(@oauth_consumer, oauth_token, oauth_secret).get_access_token :oauth_verifier => oauth_verifier
      end

      # TODO: Move this to OAuth
      create_api_method :check_access_token,
                        "vimeo.oauth.checkAccessToken"

private

      def make_request(options, authorized)
        if authorized
          raw_response = @oauth_consumer.request(:post, Vimeo::Advanced::Base::ENDPOINT, get_access_token, {}, options).body
        else
          raw_response = @oauth_consumer.request(:post, Vimeo::Advanced::Base::ENDPOINT, nil, {}, options).body
        end

        response = JSON.parse(raw_response)
        validate_response! response
        response
      end

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