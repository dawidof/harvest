# frozen_string_literal: true

module Requests
  def post_request(url, body: {}, headers: {})
    Faraday.post(url, body.to_json, with_default_headers(headers))
  end

  def get_request(url, body: nil, headers: {})
    Faraday.get(url, body, with_default_headers(headers))
  end

  def with_default_headers(headers)
    headers.merge('User-Agent' => ENV['USER_AGENT'])
  end
end
