require 'rails_helper'

RSpec.feature 'User reviews completed spreadsheet' do
  feature 'Signed-in user can review an uploaded completed spreadsheet' do
    scenario 'successfully review and complete the submission process' do
      mock_sso_with(email: 'email@example.com')
      mock_tasks_endpoint!

      visit '/tasks'
      click_on 'Sign in'

      # TODO: mock already uploaded file in the submission process within a task
      # TODO: mock backend transactions and API calls when that's added
      visit upload_review_task_path(id: temp_task_id)
      expect(page).to have_content(I18n.t('uploads.review.heading'))
      expect(page).to have_content(I18n.t('uploads.review.intro'))
      expect(page).to have_link(I18n.t('uploads.review.submit'))
      expect(page).to have_link(I18n.t('uploads.review.back'))

      click_on I18n.t('uploads.review.submit')
      expect(current_path). to eq(complete_task_path(id: temp_task_id))

      expect(page).to have_content(I18n.t('tasks.complete.message.para_1'))
      expect(page).to have_content('£xxxx')
    end

    scenario 'and cancel/go back to re upload the spreadsheet' do
      mock_sso_with(email: 'email@example.com')
      mock_tasks_endpoint!

      visit '/tasks'
      click_on 'Sign in'

      # TODO: mock already uploaded file in the submission process within a task
      # TODO: mock backend transactions and API calls when that's added
      visit upload_review_task_path(id: temp_task_id)
      expect(page).to have_content(I18n.t('uploads.review.heading'))
      expect(page).to have_content(I18n.t('uploads.review.intro'))
      expect(page).to have_link(I18n.t('uploads.review.submit'))
      expect(page).to have_link(I18n.t('uploads.review.back'))

      click_on I18n.t('uploads.review.back')
      expect(current_path). to eq(tasks_path)

      expect(page).to have_content(I18n.t('tasks.index.completed_return'))
    end
  end
end
