require 'rails_helper'

RSpec.describe 'the custom error pages' do
  it 'responds with a custom 404 page' do
    get '/404'

    expect(response).to have_http_status(:not_found)
    expect(response.body).to include 'Page not found'
  end

  it 'responds with a custom 500 page' do
    get '/500'

    expect(response).to have_http_status(:internal_server_error)
    expect(response.body).to include 'Sorry, there is a problem with the service'
  end
end
