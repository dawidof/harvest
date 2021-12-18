# frozen_string_literal: true

class User < ApplicationRecord
  has_many :users_tokens, -> { order(id: :desc) }, dependent: :delete_all
  has_many :tokens, through: :users_tokens, dependent: :delete_all

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :avatar_url, presence: true
  validates :provider, presence: true
  validates :uid, presence: true
  validates :provider, uniqueness: { scope: :uid }

  def assign_user_data(data)
    self.first_name = data['first_name']
    self.last_name = data['last_name']
    self.email = data['email']
    self.avatar_url = data['avatar_url']
    self.received_data = data.slice(*%w[is_active weekly_capacity])
  end

  def token
    tokens.first
  end
end
