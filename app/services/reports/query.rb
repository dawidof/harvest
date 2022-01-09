# frozen_string_literal: true

module Reports
  class Query < Callable
    include Requests

    BASE_URI = 'https://api.harvestapp.com'

    param :token
    param :page, default: proc { 1 }
    option :from_date, default: proc { 1.month.ago.to_date }
    option :to_date, default: proc { Date.today }

    def call
      get_request("#{BASE_URI}/v2/time_entries", body: query, headers: headers)
    end

    private

    def headers
      {
        Authorization: "Bearer #{token.access_token}",
        'Harvest-Account-Id' => token.account_id
      }
    end

    def query
      { from: from_date.to_date, to: to_date.to_date, per_page: 100, page: page }
    end
  end
end
