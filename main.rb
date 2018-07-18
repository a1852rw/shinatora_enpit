require 'sinatra'

get "/" do
    erb :index
end

get '/login' do
    @uname = ""
    erb :login
end

post '/login' do
    @uname = params[:uname]
    erb :message
end


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
