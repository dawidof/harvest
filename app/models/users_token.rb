# frozen_string_literal: true

class UsersToken < ApplicationRecord
  belongs_to :user
  belongs_to :token

  validates :user_id, uniqueness: { scope: :token_id }
end
