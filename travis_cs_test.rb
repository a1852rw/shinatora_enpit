ENV['RACK_ENV'] = 'test'

require File.expand_path(File.dirname(__FILE__) + '/main.rb')
require 'test/unit'
require 'rack/test'

OUTER_APP = Rack::Builder.parse_file("config.ru").first

class MainTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    OUTER_APP
  end

  def test_sample_main
    get '/'
    assert last_response.ok?
    puts "----test_sample_main ----"
    puts last_response
    puts "----test_sample_main ----"
  end

  def test_get_login_test
    get '/login'
    assert last_response.ok?
    puts "----get_login_test ----"
    puts last_response
    puts "----get_login_test ----"
  end

#  def test_post_login_test
#    post '/login'
#    assertt last_response.ok?
#    puts "----post_login_test ----"
#    puts last_response
#    puts "----post_login_test ----"
#  end

  def test_get_message_test
    get '/message'
    assert last_response.ok?
    puts "----get_message_test ----"
    puts last_response
    puts "----get_message_test ----"
  end

 # def test_post_message_test
 #   post '/message'
 #   assert last_response.ok?
 #   puts "----post_message_test ----"
 #   puts last_response
 #   puts "----post_message_test ----"
 # end

end
