# frozen_string_literal: true

module Harvest
  module Tokens
    class CreateUser < Callable
      include Requests
      param :token

      def call
        user_info = show_my_info(token)

        # puts JSON.pretty_generate(user_info)
        user = User.find_or_initialize_by(provider: 'harvest', uid: user_info['id'])
        user.assign_user_data(user_info)
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
