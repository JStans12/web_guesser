require 'sinatra'
require 'sinatra/reloader'

@@secret_number = rand(100)
@@remaining_guesses = 6

get '/' do
  guess = params['guess'].to_i
  cheat = params['cheat'] || false
  number = @@secret_number
  guess_message = check_guess(guess)
  remaining_guesses = count_guesses
  win_or_lose_message = win_or_lose(guess_message, remaining_guesses)

  erb :index, :locals => {:number => number,
                          :guess_message => guess_message,
                          :remaining_guesses => remaining_guesses,
                          :win_or_lose_message => win_or_lose_message,
                          :cheat => cheat}
end

def check_guess(guess)
  return "Way too high!" if guess > @@secret_number + 5
  return "Too high!"     if guess > @@secret_number
  return "Way too low"   if guess < @@secret_number - 5
  return "Too low"       if guess < @@secret_number
  return "Nailed it!"    if guess == @@secret_number
end

def count_guesses
  @@remaining_guesses -= 1
  return "Out of guesses!" if @@remaining_guesses == 0   
  return "#{@@remaining_guesses} guesses left."
end

def win_or_lose(guess_message, remaining_guesses)
  return win if guess_message == "Nailed it!"
  return lose if remaining_guesses == "Out of guesses!"
end

def win
  @@secret_number = rand(100)
  @@remaining_guesses = 5
  "You win!"
end

def lose
  @@secret_number = rand (100)
  @@remaining_guesses = 5
  "You lose!"
end