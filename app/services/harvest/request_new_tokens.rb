# frozen_string_literal: true

module Harvest
  class GetTokenError < StandardError; end

  class RequestNewTokens < Base
    param :code
    param :scope

    def call
      token = Harvest::Tokens::ReceiveTokens.call(code, scope)
      user = Harvest::Tokens::CreateUser.call(token)
      UsersToken.find_or_create_by!(user: user, token: token)
    end
  end
end
