require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    @letters = []
    10.times { @letters << ('A'..'Z').to_a.sample[0] }
  end

  def score
    @answer = params[:answer]
    @letters = params[:letters].split

    url = "https://wagon-dictionary.herokuapp.com/#{@answer}"
    usewagondic = URI.parse(url).read
    word_hash = JSON.parse(usewagondic)
    if word_hash['found'] == false || @answer.length > @letters.length
      @result = "Sorry but #{@answer} does not seem to be a valid English word..."
      @score = 'Your score is 0. Try again!'
    elsif @answer.upcase.chars.map.all? { |letter| @answer.upcase.chars.count(letter) <= @letters.count(letter) }
      @result = "Congratulations! #{@answer} is English words!"
      @score = "Your score is #{@answer.length * 5}!"
    else
      @result = "Sorry but #{@answer} can't be built out of #{@letters.join}"
      @score = 'Your score is 0. Try again!'
    end
  end
end
