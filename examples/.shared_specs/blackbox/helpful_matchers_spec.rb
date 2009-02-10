require File.dirname(__FILE__) + '/../spec_helper'

describe 'Helpful Matchers' do

  it 'response.should be_success' do
    request('/').should be_success
  end

  it 'response.should be_redirect' do
    request('/redirect?to=http://www.google.com').should be_redirect
  end

  it 'response.should redirect_to(url)' do
    request('/redirect?to=http://www.google.com').should redirect_to('http://www.google.com')
  end

  it 'relative redirect to should work' do
    request('/relative').should be_redirect
    request('/relative').should redirect_to('/i_am_relative')
  end

  it 'response.should have_text("")' do
    request('/some_text').body.should include('how goes it?')
    request('/some_text').body.should include('how goes it?')

    request('/some_text').body.should_not include('how goesss it?')
    request('/some_text').body.should_not include('how goesss it?')
  end

  it 'response.should have_tag("")' do
    request('/some_html').body.should have_tag('p#this-one')
    request('/some_html').body.should_not have_tag('p#thisss-one')

    request('/some_html').body.should have_tag('p#bacon-one')
    request('/some_html').body.should_not have_tag('p#bacon-two')
  end

  it 'response.should have_tag(""){ with_tag("") }' do
    request('/some_html').body.should have_tag('#chunky-one') do
      with_tag('b', 'chunky one')
      with_tag('div')
      with_tag('b', 'chunky one')
    end

    request('/some_html').body.should_not have_tag('b#chunky-one')
  end

end
