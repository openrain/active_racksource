ActiveRacksource
================

NOT COMPLETE - CHECK BACK REAL SOON!
====================================

Active**Rack**source is a [Rack][] backend for [ActiveResource][].

Ok ... What does that mean?
---------------------------

Here's an example, let's define a simple [ActiveResource][] library

    ActiveResource::Base.site = 'http://lots-of-dogs.com/'

    class Dog < ActiveResource::Base
    end

If you run the following command, it will runs over HTTP and actually request http://lots-of-dogs.com/dogs.xml 

    >> Dog.find( :all ).length
    => 1462

But, if you give [ActiveResource][] a [Rack][] application to use as a backend ...

    require 'active_racksource'

    ActiveResource::Base.app = @my_rack_application

And run the command again ...

    >> Dog.find( :all ).length
    => 5

Then it runs against the [Rack][] application, not over any TCP or anything!  This is great for testing 
your [ActiveResource][] APIs for *your* web applications.  If you don't have the code for the web application 
your API calls, then you won't find this useful.  This is good if you're wanting to test your own 
web appliction's API.

Cool, how should I get started?
-------------------------------

... ( documentation coming soon! ) ...


[rack]:            http://rack.rubyforge.org
[activeresource]:  http://api.rubyonrails.org/classes/ActiveResource/Base.html
