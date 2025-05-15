# frozen_string_literal: true

module PixCharge
  class Client
    def initialize(api_key: ENV['API_KEY'], api_host: ENV['API_HOST'])
      @api_key = api_key
      @api_host = api_host
    end

    def create_pix(params = {})
      Requests::CreatePix.new(api_key: @api_key, api_host: @api_host).call(params)
    end
  end
end
