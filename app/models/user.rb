# frozen_string_literal: true

class User < ApplicationRecord
  DEFAULT_CATEGORIES = %i[development code_review meeting support admin design project_managment research].freeze
  SETTINGS = %i[company_name agreement_date].freeze
  DEFAULT_CATEGORY_TASKS = DEFAULT_CATEGORIES.map { [_1, I18n.t("categories.#{_1}")] }.to_h.freeze

  has_many :tokens, -> { order(id: :desc) }, dependent: :delete_all

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :avatar_url, presence: true
  validates :provider, presence: true
  validates :uid, presence: true
  validates :provider, uniqueness: { scope: :uid }

  store :task_categories, accessors: DEFAULT_CATEGORY_TASKS.keys
  store :settings, accessors: SETTINGS

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

  DEFAULT_CATEGORY_TASKS.each do |title, default_value|
    define_method(title) { task_categories.fetch(title, default_value) }

    define_method("#{title}=") do |value|
      if value == DEFAULT_CATEGORY_TASKS[title]
        self.task_categories = task_categories.except(title)
      else
        write_store_attribute(:task_categories, title, value)
      end
    end
  end
end
