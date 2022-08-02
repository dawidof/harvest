# frozen_string_literal: true

module Harvest
  module Tokens
    class CreateUser < Callable
      include Requests
      param :token

      def call
        user_info = show_my_info(token)

        # puts JSON.pretty_generate(user_info)
        user = User.find_or_initialize_by(provider: 'harvest', uid: user_info['id']) do |u|
          u.assign_user_data(user_info)
          u.settings = { uid: user_info['id'] }
        end
        user.save!

        User.default_categories.each do |legacy_title, title|
          user.assign_category_by_title(legacy_title: legacy_title, title: title)
        end

        user.save!
        user
      end

      private

      def show_my_info(token)
        Harvest::UserInfo.call(token)
      end
    end
  end
end
