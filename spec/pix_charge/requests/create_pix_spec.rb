require 'spec_helper'
require 'dotenv/load'

RSpec.describe PixCharge::Requests::CreatePix, type: :request do
  let(:valid_params) { build(:create_pix_params) }

  context 'with valid parameters', :vcr do
    it 'returns successfully 201 creates a pix charge' do
      response = described_class.new(
        api_key: ENV['API_KEY'],
        api_host: ENV['API_HOST']
      ).call(valid_params)

      expect(response["data"]).to include("payer")
      expect(response["status"]).to eq(201)
    end
  end

  context 'with invalid parameters', :vcr do
    it 'returns error 422 with validation messages' do
      invalid_params = valid_params.merge(fine_type: 999)

      response = described_class.new(
        api_key: ENV['API_KEY'],
        api_host: ENV['API_HOST']
      ).call(invalid_params)

      expect(response).to include('errors')
      expect(response["status"]).to eq(422)
    end
  end

  context 'with invalid token', :vcr do
    it 'returns error 401 - Unauthorized' do
      response = described_class.new(
        api_key: 'TOKEN_FAKE',
        api_host: ENV['API_HOST']
      ).call(valid_params)

      expect(response).to include('errors').or include('message')
      expect(response["status"]).to eq(401)
    end
  end
end

