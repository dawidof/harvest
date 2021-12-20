# frozen_string_literal: true

class ApplicationController < ActionController::Base
  rescue_from Harvest::GetTokenError, with: :token_error

  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    @current_user ||= token&.user if session[:access_token]
  end

  def authenticate
    redirect_to root_path, alert: 'You must be logged in to access this page.' unless current_user
  end

  private

  def token_error(exception)
    @error = exception.message
    render('dashboard/token_error')
  end

  def token
    Token.find_by(access_token: session[:access_token], expires_at: Time.now..)
  end
end
