require File.dirname(__FILE__) + '/../spec_helper'

describe 'Home Page' do

  it 'should say something by itself' do
    req( '/' ).body.should include('You said nothing')

    # this works, but you should probably be careful using 
    # 'request' and 'response' in Rails specs ... ?

    request( '/' ).body.should include('You said nothing')

    response = req( '/' )
    response.body.should include('You said nothing')
  end

  it 'should say whatever I tell it to' do
    req( '/', :method => :post, :params => { :say => 'hello' } ).body.should include('You said hello')
  end

  it 'should default to a POST if params are present' do
    request('/print-method').body.should == 'get'
    request('/print-method', :params => { :hi => 'there' }).body.should == 'post'
    request('/print-method', :params => { :hi => 'there' }, :method => :post ).body.should == 'post'
    request('/print-method', :params => { :hi => 'there' }, :method => :put ).body.should == 'put'
    request('/print-method', :params => { :hi => 'there' }, :method => :get ).body.should == 'get'
  end

end
