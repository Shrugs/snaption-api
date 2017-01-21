class ApplicationController < ActionController::API

  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :authenticate!

  def authenticate!
    authenticate_or_request_with_http_token do |token, options|
      @current_token = token
      ApiKey.find_by(authentication_token: token).andand.user
    end
  end

  def current_user
    @current_user ||= ApiKey.find_by(authentication_token: @current_token).user
  end
end
