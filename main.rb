require 'sinatra'
# Rubyにおいて「main.rb」はページの構成を規定するファイル

get "/" do
    erb :index
end
# メインページについて記述


get '/login' do
    @uname = ""
    erb :login
end
# ログインページについて記述、ここでページ情報を読み込む


post '/login' do
    @uname = params[:uname]
    erb :message
end
# 入力されたユーザー情報を読み込む


@@messages = ""

get '/message' do
    
    erb :message
end

post '/message' do
    @uname = params[:uname]
    @message = "#{(Time.now).strftime("%Y/%m/%d %H:%M")}" + "  " + @uname + "-san wrote:<br>" + params[:message]
    @@messages = @message + "<br><br>" + @@messages
    puts @@messages
    erb :message
end
