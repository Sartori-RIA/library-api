# frozen_string_literal: true

module Helpers
  module Headers
    def auth_header(user)
      headers = unauthenticated_header
      Devise::JWT::TestHelpers.auth_headers(headers, user)
    end

    def unauthenticated_header
      { Accept: 'application/json', 'Content-Type' => 'application/json' }
    end
  end
end

RSpec.configure do |config|
  config.include Helpers::Headers
end

