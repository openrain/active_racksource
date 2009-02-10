class ActiveRacksource #:nodoc:

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
