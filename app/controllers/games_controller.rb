class GamesController < ApplicationController
  require "json"
  require "open-uri"

  def initialize
    @alphabet = %w(a b c d e f g h i j k l m n o p q r s t u v w x y z)
  end

  def new
    @letters = @alphabet.sample(10)
  end

  def score
    letters = params[:letters]
    guess = params["answer"]
    if guess.each_char.select { |letter| letters.include?(letter)}.size == guess.size
      url = "https://dictionary.lewagon.com/#{guess}"
      tested_word = URI.parse(url).read
      if JSON.parse(tested_word)["found"]
        @result = "Congratulations ! #{guess} is a valid English word !"
      else
        @result = "Sorry but #{guess} does not seem to be a valid English word"
      end
    else
      @result = "Sorry but #{guess} can't be build out of #{letters}"
    end
  end
end
