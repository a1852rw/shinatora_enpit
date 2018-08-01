# -*- coding: utf-8 -*-

# このファイルは動作確認のために作られました。2018/8/1現在プログラムの動作には関与しません

require 'sinatra'
require 'json'
require "date"
require File.expand_path(File.dirname(__FILE__) + '/JsonHelper.rb')
require File.expand_path(File.dirname(__FILE__) + '/JsonData.rb')

use Rack::Logger

    # puts "!!!!"
    j = J_Data.getData
    # puts 'it is json' if JSON.is_json?(j)
    # j = JSON.parse(j)
    puts j
    # puts "!!!!"
    
    # puts j.count
    # puts j["data"].count
    # puts j["data"][0]
    
helpers do
  def logger
    request.logger
  end
end

before do
    puts "!!!"
    puts Time.now
    puts "!BEFORE!!!"
    
    puts "params"
    puts params
    puts params.count
    puts "params"
    
    if (params.count == 2 && params[:name] != "" && params[:context] != "null")
      element = {
              JSON_KeyWord.id => j["data"].count + 1,
              JSON_KeyWord.name => params[:name],
              JSON_KeyWord.context => params[:context],
              JSON_KeyWord.date => Date.today()
            }
      J_Data.putData(element)
      
      j = J_Data.getData
      
    end
    
    puts "!!!"
end

after do
    puts "!!!"
    puts Time.now
    puts "!AFTER!!!"
    puts "!!!"
end

get '/' do
    @hello = "こんにちは、hogehoge!"
    # logger.info "///"
    # logger.info Time.now
  # puts j["data"][0][JSON_KeyWord.id]
  # puts j["data"][0][JSON_KeyWord.name]
  # puts j["data"][0][JSON_KeyWord.context]
  # puts j["data"][0][JSON_KeyWord.date]
    
  # @id = j["data"][0][JSON_KeyWord.id]
  # @name = j["data"][0][JSON_KeyWord.name]
  # @context = j["data"][0][JSON_KeyWord.context]
  # @date = j["data"][0][JSON_KeyWord.date]
    @raw = j["data"]
    erb :index
end

post '/form' do
    @input1 = params

    @raw = j["data"]
    @hello = @input1
    erb :index
end
