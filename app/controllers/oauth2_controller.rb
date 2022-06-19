# frozen_string_literal: true

class Oauth2Controller < ApplicationController
  def callback
    save_token.then { authenticate(_1) }

    (redirect_to(dashboard_path) and return) if @error.nil?
  end

  private

  def save_token
    data = params.slice(:code, :scope).values
    Harvest::RequestNewTokens.call(*data)
  rescue StandardError => exception
    puts exception.inspect
    @error = "Error occurred while receiving tokens from harvest: #{exception.message}"
  end

  def authenticate(token)
    session[:access_token] = token.access_token
  end
end
