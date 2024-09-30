# Orm
require 'sequel'

# Conection from SQlite
DB = Sequel.sqlite('urls.db')

# Urls table
DB.create_table? :urls do
  primary_key :id
  String :original_url, text: true
  String :short_url, unique: true
end

