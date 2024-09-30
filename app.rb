require 'sinatra'

get '/' do
  erb :index
end

post 'success' do
  erb :success
end

get '/:short_url' do
  'test'
end