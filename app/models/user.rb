# frozen_string_literal: true

class User < ApplicationRecord
  DEFAULT_CATEGORIES = %i[development code_review meeting support admin design project_managment research].freeze
  SETTINGS = %i[company_name agreement_date].freeze
  DEFAULT_CATEGORY_TASKS = DEFAULT_CATEGORIES.map { [_1, I18n.t("categories.#{_1}")] }.to_h.freeze
  HARVEST_CATEGORY_TASKS = DEFAULT_CATEGORIES.map { [I18n.t("harvest_categories.#{_1}"), _1] }.to_h.freeze

  has_many :tokens, -> { order(id: :desc) }, dependent: :delete_all
  has_many :histories, dependent: :delete_all
  has_many :categories, dependent: :delete_all

  accepts_nested_attributes_for :categories

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :avatar_url, presence: true
  validates :provider, presence: true
  validates :uid, presence: true
  validates :provider, uniqueness: { scope: :uid }

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

  def category_by_title(title)
    category = categories.find_or_create_by(legacy_title: title) do |cat|
      default_category = User::HARVEST_CATEGORY_TASKS.fetch(title, nil)
      cat.title = User::DEFAULT_CATEGORY_TASKS.fetch(default_category, nil)
    end

    category.title.presence || category.legacy_title
  end

  def assign_category_by_title(legacy_title:, title:)
    categories.create_with(title: title).find_or_create_by(legacy_title: legacy_title)
  end

  def self.default_categories
    User::HARVEST_CATEGORY_TASKS.transform_values { |key| User::DEFAULT_CATEGORY_TASKS[key] }
  end
end
