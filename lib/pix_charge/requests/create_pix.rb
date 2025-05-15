# frozen_string_literal: true

module PixCharge
  module Requests
    class CreatePix
      PATH = '/v2/charge/pix'

      def initialize(api_key:, api_host:, idempotency_key: nil, user_agent: nil)
        @api_key = api_key
        @api_host = api_host
        @idempotency_key = idempotency_key || SecureRandom.uuid
        @user_agent = user_agent || 'PixCharge Ruby Client'
      end

      def call(params)
        conn = Faraday.new(
          url: @api_host,
          headers: {
            'Authorization' => "Bearer #{@api_key}",
            'Accept' => 'application/json',
            'Content-Type' => 'application/json',
            'X-Idempotency-Key' => @idempotency_key,
            'User-Agent' => @user_agent
          }
        )

        response = conn.post(PATH) do |req|
          req.body = JSON.generate(params)
        end

        JSON.parse(response.body)
      end
    end
  end
end
