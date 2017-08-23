class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  before_action :authorized

  def issue_token(payload)
    JWT.encode(payload, "learnlovecode")
  end

  def decoded_token(token)
    begin
      JWT.decode(token, "learnlovecode")
    rescue JWT::DecodeError
      return nil
    end
  end

  def logged_in?
    !!current_user
  end

  def current_user
    authenticate_or_request_with_http_token do |token, options|
      decoded_hash = decoded_token(token)
      user_id = decoded_hash[0]["user_id"]
      @current_user ||= User.find(user_id)
    end
  end

  def authorized
    render json: { message: "Not authorized"}, status: 404 unless logged_in?
  end
end
