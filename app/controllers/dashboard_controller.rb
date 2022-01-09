# frozen_string_literal: true

class DashboardController < ApplicationController
  include TimeHelper
  before_action :authenticate
  before_action :load_dates, only: %i[index create]

  def index
    redirect_to settings_path if current_user.company_name.empty? || current_user.agreement_date.empty?
  end

  def create
    @history.user = current_user
    if @history.save
      file = Reports::GenerateExcel.call(@history.data.map(&:deep_symbolize_keys), current_user)
      send_data file.read, filename: file.original_filename
    else
      render :index
    end
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
    params.require(:user).permit(User::DEFAULT_CATEGORY_TASKS.keys + User::SETTINGS)
  end

  def date_params
    return { from_date: 1.month.ago.to_date, to_date: Date.today } unless params.key?(:history)

    params.require(:history).permit(:from_date, :to_date)
  end

  def history_params
    return {} unless params.key?(:history)

    params.require(:history).permit(:from_date, :to_date, :total, entries: {})
  end

  def load_dates
    @dates = History.new(date_params)
    @data = Reports::TimeReports.new(current_user.token,
                                     from_date: @dates.from_date,
                                     to_date: @dates.to_date)
                                .count_hours
    @history = History.new(history_params)
  end
end
