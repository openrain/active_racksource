$:.unshift File.dirname(__FILE__)

require 'rubygems' # i'd like to remove this - it's becoming less conventional to have this in ruby gems / libraries

begin
  require 'active_resource'
rescue LoadError
  raise "active_racksource requires active_resource, try: gem install activeresource"
end

begin
  require 'rackbox'
rescue LoadError
  raise "active_racksource requires rackbox, try: gem install remi-rackbox -s http://gems.github.com"
end

require 'active_racksource/active_racksource'
require 'active_racksource/response'
require 'active_racksource/http'
require 'active_racksource/base'
require 'active_racksource/connection'

ActiveResource::Base.send       :include, ActiveRacksource::Base
ActiveResource::Connection.send :include, ActiveRacksource::Connection
