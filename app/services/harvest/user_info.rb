# frozen_string_literal: true

module Harvest
  class UserInfo < Callable
    include Requests
    param :token

    def call
      url = 'https://api.harvestapp.com/v2/users/me'
      headers = { 'Authorization' => "Bearer #{token.access_token}", 'Harvest-Account-ID' => token.account_id }
      response = get_request(url, body: nil, headers: headers)
      return JSON.parse(response.body) if response.status == 200

      raise GetTokenError, JSON.parse(response.body).fetch('error_description')
    end
  end
end
