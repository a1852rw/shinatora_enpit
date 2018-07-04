require 'sinatra'

get '/' do
  "Hello World!"
end

get '/path/to' do
  "this is [/path/to]"
end

get '/hello/*' do |name|
  "Hello #{name}. how are you?"
end

get "/google" do
  require "httparty"
  HTTParty.get('http://google.com', follow_redirects: true).body
end
