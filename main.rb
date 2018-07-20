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
    if @uname == ""
        @uname = "Guest"
    else
        @uname = @uname.gsub(/</, "&lt")
        @uname = @uname.gsub(/>/, "&gt")
    end
    erb :message
end


@@messages = ""

get '/message' do
    
    erb :message
end

post '/message' do
    @uname = params[:uname]
    @message = "#{(Time.now).strftime("%Y/%m/%d %H:%M")}" + "  " + @uname + "-san wrote:<br>" + params[:message]
    @message = @message.gsub(/</, "&lt")
    @message = @message.gsub(/>/, "&gt")
    @@messages = @message + "<br><br>" + @@messages
    puts @@messages
    erb :message
end
