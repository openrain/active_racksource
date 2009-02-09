# ActiveResource client for RESTful web service
#%w( rubygems active_resource racksource thin ).each {|lib| require lib }

require 'rubygems'
require 'active_resource'
require 'thin'

#class Dog < ActiveResource::Base
#end

# HTTP
#ActiveResource::Base.site = "http://localhost:3001/"

# RACK
rack_app = Rack::Adapter::Rails.new :root => 'rails'
#ActiveResource::Base.app = rack_app

puts "quick test ... "
puts "rack app OK?"
req = Rack::MockRequest.new rack_app
puts "doing a get ..."
resp = req.get('/dogs.xml')
puts "ok? #{ resp.status }"
