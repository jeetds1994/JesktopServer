class QuestionsController < ApplicationController

  def index
    let x = FetchController.get_API_data("art")
    #this was used for testing
  end

  def category
    category = params[:category]
    @questions = Category.find_by(name: category).questions
    render json: @questions
  end

end
