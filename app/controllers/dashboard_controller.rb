# frozen_string_literal: true

class DashboardController < ApplicationController
  def index
    @user = Harvest::UserInfo.call(Token.last)
  end
end
