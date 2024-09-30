require 'sinatra'
require 'sequel'
require 'securerandom'

# Conection from SQLite
DB = Sequel.sqlite('urls.db')

# Logic to shorten
class URL < Sequel::Model(DB[:urls])  # Model from URLs
  def self.shorten(original_url)
    short_url = SecureRandom.hex(3)
    create(original_url: original_url, short_url: short_url)
  end
end

get '/' do
  erb :index
end

post '/shorten' do
  url = URL.shorten(params[:original_url])
  @short_url = "#{request.base_url}/#{url.short_url}"
  erb :success
end

get '/:short_url' do
  url = URL.find(short_url: params[:short_url])
  if url
    redirect url.original_url
  else
    "URL not found"
  end
end