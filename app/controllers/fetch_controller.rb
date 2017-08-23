require 'net/http'
require 'json'

class FetchController < ApplicationController

  def self.get_API_data(category)
      url = "http://cocktail-trivia-api.herokuapp.com/api/category/#{category}"
      uri = URI(url)
      resp = Net::HTTP.get(uri)
      data = JSON.parse(resp)
      #parsed returns an array in the format [[question, answer]]
      parsed = data.map {|x| [x["text"], x["answers"].select {|y| y["correct"]==true}[0]["text"]]}
      FetchController.saveToDB(parsed, category)
  end

  def self.saveToDB(data, category)
    c = Category.find_or_create_by(name: category)
    data.each do |qa|
      q = qa[0]
      a = qa[1]
      question = Question.find_or_create_by(question: q, answer: a)
      c.questions << question
    end
  end
end
