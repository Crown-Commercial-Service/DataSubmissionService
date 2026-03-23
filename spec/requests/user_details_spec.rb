require 'rails_helper'

RSpec.describe 'the user details page' do
  before do
    mock_notifications_endpoint!
    mock_user_with_multiple_suppliers_endpoint!
    mock_suppliers_endpoint!
  end

  describe 'visiting the user profile page' do
    it 'shows the user details' do
      stub_signed_in_user

      get user_detail_path

      expect(response).to be_successful
      expect(response.body).to include 'User Name'
      expect(response.body).to include 'user@example.com'
      expect(response.body).to include '1 October 2023'
      expect(response.body).to include 'Supplier(s)'
      expect(response.body).to include 'Bandersnatch'
      expect(response.body).to include 'San Junipero'
    end
  end

  describe 'GET /user_detail/edit' do
    it 'renders the edit form' do
      stub_signed_in_user

      get edit_user_detail_path

      expect(response).to be_successful
      expect(response.body).to include 'Change your name'
      expect(response.body).to include 'Name'
      expect(response.body).to include 'Update name'
    end
  end

  describe 'PATCH /user_detail' do
    it 'updates the user name and redirects to the profile page on success' do
      stub_signed_in_user
      mock_update_user_name_endpoint!

      patch user_detail_path, params: { name: 'New Name' }

      expect(response).to redirect_to(user_detail_path)
      follow_redirect!

      expect(response.body).to include 'Your name has been updated successfully.'
    end

    it 're-renders the edit form with an error message on failure' do
      stub_signed_in_user
      mock_update_user_name_endpoint_failure!

      patch user_detail_path, params: { name: 'New Name' }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to include 'There was a problem updating your name. Please try again.'
    end

    it 'handles connection errors gracefully' do
      stub_signed_in_user
      mock_update_user_name_endpoint_connection_error!

      patch user_detail_path, params: { name: 'New Name' }

      expect(response).to have_http_status(:service_unavailable)
      expect(response.body).to include 'There was a problem connecting to the user service. Please try again later.'
    end
  end
end
