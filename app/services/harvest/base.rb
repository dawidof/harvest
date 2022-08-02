# frozen_string_literal: true

module Harvest
  class Base < Callable
    include Requests

    private

    def client_id
      SEC.harvest.client_id
    end

    def secret_id
      SEC.harvest.secret_id
    end
  end
end
