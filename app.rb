require 'sinatra'
require 'logger'
require 'sequel'
require 'openssl'
require 'rspec'
require 'rack/test'
require 'capybara'
require 'require_all'
require 'date'

include ERB::Util

enable :sessions
set :session_secret, '8f434346648f6b96df89dda901c5176b10a6d83961dd3c1ac88b59b2dc327aa4'

DB = Sequel.sqlite("development.sqlite3", logger: Logger.new("db.log"))

require_rel "models", "controllers"

