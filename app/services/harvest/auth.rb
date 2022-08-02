# frozen_string_literal: true

module Harvest
  class Auth < Base
    def client
      @client ||= OAuth2::Client.new(SEC.harvest.client_id,
                                     SEC.harvest.secret_id,
                                     site: site_url,
                                     authorize_url: authorize_url)
    end

    def login_url
      client.auth_code.authorize_url(redirect_uri: "#{SEC.root_url}/oauth2/callback")
    end

    private

    def authorize_url
      '/oauth2/authorize'
    end

    def site_url
      'https://id.getharvest.com'
    end
  end
end
