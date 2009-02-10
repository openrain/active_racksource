require File.dirname(__FILE__) + '/../spec_helper'

describe 'Sticky Sessions' do

  it 'should work with sessions' do
    request('/print-session').body.should == ''
    request('/print-session', :params => { :session_variable => 'chunky bacon!' }).body.should == 'chunky bacon!'
    request('/print-session').body.should == 'chunky bacon!'
  end

  it 'should work with sessions (and sessions should be cleared between spec examples)' do
    request('/print-session').body.should == ''
    request('/print-session', :params => { :session_variable => 'chunky bacon!' }).body.should == 'chunky bacon!'
    request('/print-session').body.should == 'chunky bacon!'
  end

end
