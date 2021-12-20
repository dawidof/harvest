# frozen_string_literal: true

module Harvest
  class RequestNewTokens < Base
    param :code
    param :scope

    def call
      token = Harvest::Tokens::ReceiveTokens.call(code, scope)
      user = Harvest::Tokens::CreateUser.call(token)
      UsersToken.find_or_create_by!(user: user, token: token)

      token
    end
  end
end
