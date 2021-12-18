# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    @login_url = Harvest::Auth.new.login_url
  end
end
