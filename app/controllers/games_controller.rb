require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    ab = ('A'..'Z').to_a
    @letters = []
    10.times { @letters << ab.sample }
  end

  def score
    @word = params[:word].upcase
    @letters = params[:letters].split(' ')
    @list = @letters.join(', ')
    @validation = validation(exist?)
  end

  def exist?
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    read = URI.open(url).read
    parsed = JSON.parse(read)
    parsed['found']
  end

  def validation(is_a_word)
    word = @word
    letters = @letters
    if is_a_word
      in_grid = true
      word.each_char { |c| letters.include?(c) ? letters.delete_at(letters.index(c)) : in_grid = false }
      in_grid ? (return [word.length]) : (return [0, 1])
    else
      [0, 0]
    end
  end
end
