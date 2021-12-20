# frozen_string_literal: true

class DashboardController < ApplicationController
  include TimeHelper
  before_action :authenticate

  def index
    # @user = Harvest::UserInfo.call(Token.last)
    @user = User.first
  end

  def account; end

  def settings; end

  def update
    if @current_user.update(user_params)
      redirect_to settings_path, notice: 'Categories were successfully updated.'
    else
      render :settings, status: :unprocessable_entity
    end
  end

  def logout
    session.delete(:access_token)
    redirect_to root_path, notice: 'Logged out!'
  end

  private

  def user_params
    params.require(:user).permit(User::DEFAULT_CATEGORY_TASKS.keys)
  end
end
