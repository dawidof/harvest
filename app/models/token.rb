# frozen_string_literal: true

class Token < ApplicationRecord
  belongs_to :user, optional: true

  validates :access_token, presence: true
  validates :refresh_token, presence: true
  validates :scope, presence: true
  validates :token_type, presence: true
  validates :expires_at, presence: true

  def account_id
    scope.split(':').last
  end

  def self.remove_old_empty
    where(created_at: ..1.month.ago, user_id: nil).destroy_all
  end
end
