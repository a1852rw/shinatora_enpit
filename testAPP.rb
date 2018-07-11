require 'sinatra'
#require 'sinatra/reloader'

get '/' do
  erb :index_jin_0
end

post '/confirm' do
  @message = params[:message]
  erb :confirm_jin_0
end 
