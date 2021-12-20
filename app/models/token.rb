# frozen_string_literal: true

class Token < ApplicationRecord
  belongs_to :users_token, primary_key: :token_id, foreign_key: :id, optional: true
  has_one :user, through: :users_token

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
