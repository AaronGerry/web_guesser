require 'sinatra'
require 'sinatra/reloader'
require 'pry'

use Rack::Session::Cookie, {
  secret: "change_me",
  expire_after: 86400 # seconds
}

SECRET_NUMBER = rand(101)
@@number_of_guesses = 6

get '/' do
  guess = params["guess"].to_i
  message = check_guess(guess)
  @@number_of_guesses -= 1

  erb :index, :locals => {:number => SECRET_NUMBER, :message => message, :number_of_guesses => @@number_of_guesses, :difference => @difference}
end

get '/replay' do
  session.clear
  SECRET_NUMBER = rand(101)
  @@number_of_guesses = 6
  redirect '/'
end

def check_guess(guess)
  @difference = SECRET_NUMBER - guess

  if @difference == SECRET_NUMBER
    "Let's begin!"
  elsif @difference == 0
    "You got it right! Go you!"
  elsif @difference > 0
    if @difference.abs > 5
      "Way too low!"
    else
      "Too low!"
    end
  elsif @difference < 0
    if @difference.abs > 5
      "Way too high!"
    else
      "Too high!"
    end
  end
end
