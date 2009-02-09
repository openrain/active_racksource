# ActiveResource client for RESTful web service
%w( rubygems active_resource racksource thin ).each {|lib| require lib }
require '/home/remi/projects/remi/rackbox/lib/rackbox'
RackBox.verbose = true

# these need to be namespaced!
module EOL
  module API
    class Dog < ActiveResource::Base
    end
  end
end

# HTTP
ActiveResource::Base.site = "http://localhost:3001/"

# RACK
ActiveResource::Base.app = Rack::Adapter::Rails.new :root => 'rails'

puts "rack app OK? #{ Rack::MockRequest.new(ActiveResource::Base.app).get('/dogs.xml').status }"
