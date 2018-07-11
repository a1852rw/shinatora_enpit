require 'sinatra'


get '/' do
    @hello = "こんにちは、hogehoge!"
    erb :index
end

post '/form' do
    @input1 = params[:input1]
    @hello = @input1
    erb :index
end
