ENV["RAILS_ENV"] = "test"

begin
  require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
rescue LoadError
  # this isn't a rails project
end

require 'spec'

if defined? RAILS_ENV
  require 'spec/rails' if defined?RAILS_ENV
end

Spec::Runner.configure do |config|
  # spec configuration
end
