require 'sinatra'
require 'sinatra/reloader'

SECRET_NUMBER = rand(100)
number = SECRET_NUMBER

get '/' do
  guess = params['guess'].to_i
  message = check_guess(guess)
  erb :index, :locals => {:number => number, :message => message}
end

def check_guess(guess)
  return "Way too high!" if guess > SECRET_NUMBER + 5
  return "Too high!" if guess > SECRET_NUMBER
  return "Way too low" if guess < SECRET_NUMBER - 5
  return "Too low" if guess < SECRET_NUMBER
  return "Nailed it!" if guess == SECRET_NUMBER
end