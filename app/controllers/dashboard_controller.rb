# frozen_string_literal: true

class DashboardController < ApplicationController
  include TimeHelper
  before_action :authenticate

  def index
    # @user = Harvest::UserInfo.call(Token.last)
    @user = User.first
  end

  def account
    @user = User.first
  end

  def logout
    session.delete(:access_token)
    redirect_to root_path, notice: 'Logged out!'
  end
end
