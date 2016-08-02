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
  else
    session[:random_number]
  end

  number = session[:random_number]
  erb :index, :locals => {:number => number}
end
