require 'sinatra'
require 'sinatra/reloader'
require 'pry'

use Rack::Session::Cookie, {
  secret: "change_me",
  expire_after: 86400 # seconds
}

get '/' do
  if session[:random_number].nil?
    session[:random_number] = rand(101)
  end
  "Your random number is: #{session[:random_number]}"
end
