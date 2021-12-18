# frozen_string_literal: true

module Harvest
  module Tokens
    class ReceiveTokens < Base
      param :code
      param :scope

      def call
        response = request_tokens
        expires_at = Time.at(Time.now.to_i + response['expires_in'])
        access_token, refresh_token, token_type = response.slice(*%w[access_token refresh_token token_type]).values

        Token.create!(access_token: access_token,
                      refresh_token: refresh_token,
                      expires_at: expires_at,
                      token_type: token_type,
                      code: code,
                      scope: scope)
      end

      private

      def request_tokens
        url = 'https://id.getharvest.com/api/v2/oauth2/token'
        headers = { 'Content-Type' => 'application/json' }
        response = post_request(url, body: request_body, headers: headers)

        return JSON.parse(response.body) if response.status == 201

        raise GetTokenError, JSON.parse(response.body).fetch('error_description')
      end

      def request_body
        {
          code: code,
          client_id: client_id,
          client_secret: secret_id,
          grant_type: 'authorization_code'
        }
      end
    end
  end
end
