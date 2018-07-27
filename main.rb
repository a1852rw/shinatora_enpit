# -*- coding: utf-8 -*-
# Rubyにおいて「main.rb」はページの構成を規定するファイル

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

 if (params[:delete_id])
   puts "find delete_id"
   puts params[:delete_id]
   J_Data.popData(params[:delete_id])
   j = J_Data.getData
 end
 
 if ( params[:name] && params[:context] && params[:name] != "" && params[:context] != "")
    @context = params[:context].gsub(/</, "&lt")
    @context = @context.gsub(/>/, "&gt")
    element = {
                JSON_KeyWord.id => J_Data.getLastID().to_i+1, # j["data"].count + 1,
                JSON_KeyWord.name => params[:name],
                JSON_KeyWord.context => @context,
                JSON_KeyWord.date => Time.now.strftime("%Y/%m/%d %H:%M")
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
# メインページについて記述


get '/login' do
    @name = ""
    erb :login
end
# ログインページについて記述、ここでページ情報を読み込む


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

# 入力されたユーザー情報を読み込む
get '/message' do
    @name = params[:name] ? params[:name] : "Guest"
    @raw = j["data"]
    erb :message
end

# 入力されたユーザー情報を書き込む
post '/message' do
    @name = params[:name] ? params[:name] : "Guest"
    @raw = j["data"]
    erb :message
end
