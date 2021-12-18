# frozen_string_literal: true

class Token < ApplicationRecord
  validates :access_token, presence: true
  validates :refresh_token, presence: true
  validates :code, presence: true
  validates :scope, presence: true
  validates :token_type, presence: true
  validates :expires_at, presence: true

  def account_id
    scope.split(':').last
  end
end
