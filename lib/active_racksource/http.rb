class ActiveRacksource #:nodoc:

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

      ActiveRacksource::Response.new rack_response
    end

  end

end
