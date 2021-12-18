# frozen_string_literal: true

class ApplicationController < ActionController::Base
  rescue_from Harvest::GetTokenError, with: :token_error

  private

  def token_error(exception)
    @error = exception.message
    render('dashboard/token_error')
  end
end
