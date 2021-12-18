# frozen_string_literal: true

module Harvest
  class Base < Callable
    include Requests

    private

    def client_id
      ENV['HARVEST_CLIENT_ID']
    end

    def secret_id
      ENV['HARVEST_SECRET_ID']
    end
  end
end
