# frozen_string_literal: true

module Harvest
  class RequestNewTokens < Base
    param :code
    param :scope

    def call
      token = Harvest::Tokens::ReceiveTokens.call(code, scope)
      user = Harvest::Tokens::CreateUser.call(token)
      token.update!(user: user)
      remove_old_tokens(user)

      token
    end

    private

    def remove_old_tokens(user)
      Token.where(created_at: ..1.month.ago, user: user).destroy_all
    end
  end
end
