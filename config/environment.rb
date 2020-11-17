# Load the Rails application.
require_relative 'application'

ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] ||{
    adaptor: 'sqlite3',
    database: 'db/development.sqlite'
})

# Initialize the Rails application.
Rails.application.initialize!
