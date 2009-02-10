class ActiveRacksource #:nodoc:

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

end
