require 'sinatra' # Framework ruby
require 'sequel' # Orm SQLite
require 'securerandom' # Gem for generate code aleatory

# Conection from SQLite
DB = Sequel.sqlite('urls.db')

# Logic to shorten
class URL < Sequel::Model(DB[:urls])  # Model from URLs
  def self.shorten(original_url)
    short_url = SecureRandom.hex(3)
    create(original_url: original_url, short_url: short_url)
  end
end

# Route root
get '/' do
  erb :index
end

# Shortener url
post '/shorten' do
  url = URL.shorten(params[:original_url])
  @short_url = "#{request.base_url}/#{url.short_url}"
  erb :success
end

# Logic to redirect
get '/:short_url' do
  url = URL.find(short_url: params[:short_url])
  if url
    redirect url.original_url
  else
    "URL not found"
  end
end