require 'sinatra'

set :public_folder, File.dirname(__FILE__) + '/static'

get '/main' do
    erb :indexi
end

post '/' do
    
end
