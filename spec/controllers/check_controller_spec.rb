require 'rails_helper'

RSpec.describe CheckController, type: :controller do
  describe 'GET #index' do
    it 'returns a JSON response with status ok' do
      get :index

      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq('application/json; charset=utf-8')

      json_response = JSON.parse(response.body)
      expect(json_response).to eq({ 'status' => 'ok' })
    end
  end
end
