# ActiveResource overrides

class ActiveRacksource

  # NOTES ...
  #
  # the object http.send :foo returns should have
  #   #code:    string representation of status code, eg. '200' or '404'
  #   #message: string message, eg. 'OK' or 'Not Found'
  #   #body:    string response body
  #
  class Response
    attr_accessor :rack_response

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

    def method_missing name, *args
      @rack_response.send name, *args
    end
  end

  # Adapter ... acts like Net::HTTP but actually works against a Rack application
  class HTTP

    # Rack application
    attr_accessor :app

    # Initialized a new ActiveRacksource::HTTP
    #
    # ==== Parameters
    # app: a Rack application
    #
    def initialize app = ActiveResource::Base.app
      @app = RackBox::App.new app
    end

    #def request
    #  Rack::MockRequest.new @app
    #end

    def method_missing method, url, *args
      
      case args.length
      when 0
        headers = { }
      when 1
        headers = args.first
      when 2
        if args.last.is_a?Hash
          headers = args.last
          data    = args.first
        else
          raise "not sure howto #{ method.inspect } url:#{ url.inspect } with these args:#{ args.inspect }"
        end
      else
        raise "not sure howto #{ method.inspect } url:#{ url.inspect } with these args:#{ args.inspect }"
      end

      request_options = { }
      request_options[:method] = method
      request_options[:data]   = data   if data
      request_options.merge!( headers ) if headers

      rack_response = @app.request url, request_options
      #puts "response status: #{ rack_response.status }"
      #puts "response body: #{ rack_response.body }"

      ActiveRacksource::Response.new rack_response
    end

  end

  # Overrides parts of ActiveResource::Base for ActiveRacksource (to use Rack instead of HTTP)
  module Base
    
    def self.included base
      base.extend ClassMethods
    end

    module ClassMethods
      
      def app= rack_app
        @rack_app = rack_app
      end

      def app
        @rack_app
      end

    end

  end

  # Overrides parts of ActiveResource::Connection for ActiveRacksource (to use Rack instead of HTTP)
  module Connection

    def self.included base
      base.instance_eval {
        alias_method_chain :http, :rack_instead_of_real_http
      }
    end

    # Overrides ActiveResource::Connection#http, returning our own object
    # that uses a Rack application instead of actually going over HTTP
    #
    # example of what the HTTP object might get sent:
    #   http.send( :get,    "/dogs.xml",   [{"Accept"=>"application/xml"}] )
    #   http.send( :post,   "/dogs.xml",   ["<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<dog>\n  <name>Rover</name>\n</dog>\n", {"Content-Type"=>"application/xml"}])
    #   http.send( :delete, "/dogs/6.xml", [{"Accept"=>"application/xml"}])
    #   http.send( :put,    "/dogs/1.xml", ["<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<dog>\n  <name>spot</name>\n  <created-at type=\"datetime\">2009-02-09T18:27:11Z</created-at>\n  <updated-at type=\"datetime\">2009-02-09T18:27:11Z</updated-at>\n  <id type=\"integer\">1</id>\n</dog>\n", {"Content-Type"=>"application/xml"}])
    #
    # the object http.send :foo returns should have
    #   #code:    string representation of status code, eg. '200' or '404'
    #   #message: string message, eg. 'OK' or 'Not Found'
    #   #body:    string response body
    #
    def http_with_rack_instead_of_real_http
      if ActiveResource::Base.app
        ActiveRacksource::HTTP.new ActiveResource::Base.app
      else
        http_without_rack_instead_of_real_http
      end
    end

  end
end

ActiveResource::Base.send       :include, ActiveRacksource::Base
ActiveResource::Connection.send :include, ActiveRacksource::Connection
