require 'bundler'
Bundler.require #will load gems

#require 'active_record'
require 'open-uri'

#environment's job to load DB

# DB = {
# 	:connection => SQLite3::Database.new("db/rooms-development.sqlite")
# }

ActiveRecord::Base.establish_connection( #when using ActiveRecord vs writing ORM - can use this vs what's above
	:adapter => "sqlite3",
	:database => "db/rooms-development.sqlite"
)

require_all 'lib'

