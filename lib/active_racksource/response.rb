class ActiveRacksource #:nodoc:

  # A thin wrapper around Rack::Response
  #
  # ActiveResource expects an HTTP Response object to be 
  # formatted in a certain way with the right methods, etc.
  #
  # This object wraps a Rack::Response and implements an 
  # inferface that supports ActiveResource
  #
  # Some methods called by ActiveResource:
  # code::    string representation of status code, eg. '200' or '404'
  # message:: string message, eg. 'OK' or 'Not Found'
  # body::    string response body
  #
  class Response

    # initialize a new ActiveRacksource::Response
    #
    # ==== Parameters
    # rack_response:: a Rack::Response instance
    #
    def initialize rack_response
      @rack_response = rack_response
    end

    def code
      @rack_response.status.to_s
    end

    def message
      if code.start_with?'2'
        'OK'
      elsif code.start_with?'4'
        'Not Found'
      elsif code.start_with?'3'
        'Redirect'
      else
        'Error'
      end
    end

    # by default, fall back to methods on the Rack::Response
    def method_missing name, *args
      @rack_response.send name, *args
    end
  end

end
