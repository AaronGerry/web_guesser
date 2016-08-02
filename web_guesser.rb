require 'sinatra'
require 'sinatra/reloader'
require 'pry'

use Rack::Session::Cookie, {
  secret: "change_me",
  expire_after: 86400 # seconds
}

SECRET_NUMBER = rand(101)

get '/' do
  guess = params["guess"].to_i
  message = check_guess(guess)
  erb :index, :locals => {:number => SECRET_NUMBER, :message => message}
end

get '/replay' do
  session.clear
  SECRET_NUMBER = rand(101)
  redirect '/'
end

def check_guess(guess)
  difference = SECRET_NUMBER - guess

  if difference == SECRET_NUMBER
    "Let's begin!"
  elsif difference == 0
    "You got it right! Go you!"
  elsif difference > 0 && difference.abs >= 5
    "Way too low!"
  elsif difference < 0 && difference.abs >= 5
    "Way too high!"
  elsif difference > 0 && difference.abs < 5
    "Too low!"
  elsif difference < 0 && difference.abs > 5
    "Too high!"
  end
end
