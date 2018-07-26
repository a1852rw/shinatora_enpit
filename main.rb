require 'sinatra'
require 'json'
require 'date'
require File.expand_path(File.dirname(__FILE__) + '/jsontest/JsonHelper.rb')
require File.expand_path(File.dirname(__FILE__) + '/jsontest/JsonData.rb')

j = J_Data.getData
puts j

before do
  puts "!Before start!"
  puts  Time.now

  puts params
#  puts params.count if !params.count.blank?

  if (params.count == 2 &&  params[:name] != "" &&  params[:context] != "null")
    element = {
                JSON_KeyWord.id => j["data"].count + 1,
                JSON_KeyWord.name => params[:name],
                JSON_KeyWord.context => params[:context],
                JSON_KeyWord.date => (Date.today).strftime("%Y/%m/%d %H:%M")
               }
    J_Data.putData(element)
    j = J_Data.getData
  end

  puts "!Before end!"
end

after do
  puts "!After start!"
  puts Time.now
  puts "!After end!"
end


get "/" do
    erb :index
end

get '/login' do
    @name = ""
    erb :login
end

post '/login' do
    @name = params[:name]
    if @name == ""
        @name = "Guest"
    else
        @name = @name.gsub(/</, "&lt")
        @name = @name.gsub(/>/, "&gt")
    end
    @raw = j["data"]
    erb :message
end


get '/message' do
    @name = params[:name]
    @raw = j["data"]
    erb :message
end

post '/message' do
    @name = params[:name]
    @raw = j["data"]
    erb :message
end
