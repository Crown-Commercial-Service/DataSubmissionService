require 'rails_helper'

RSpec.feature 'Correcting a submission by reporting no business' do
  before do
    mock_sso_with(email: 'email@example.com')
    mock_incomplete_tasks_endpoint!
    mock_complete_tasks_endpoint!
    mock_task_with_framework_endpoint!
    mock_no_business_correction_endpoint!
    mock_submission_completed_no_business_endpoint!
  end

  context 'when submission correction is enabled' do
    around(:each) do |example|
      ClimateControl.modify CORRECTION_RETURNS_ENABLED: 'yes' do
        example.run
      end
    end

    context 'when the latest submission is a business return' do
      before do
        mock_completed_task_endpoint!
      end

      scenario 'user corrects a submission, reporting "no business" when linked to one supplier' do
        mock_user_endpoint!

        visit '/'
        click_button 'sign-in'

        click_link 'History'
        click_link 'View'
        click_link 'Correct this return'

        expect(page).to have_content 'Cheese Board 5'
        expect(page).to have_content 'July 2018'
        expect(page).to_not have_content 'Bobs Cheese Shop'

        click_on 'Report no business'

        expect(page).to have_content 'This is a correction'
        expect(page).to have_content 'Report no business for CBOARD5'
        expect(page).to_not have_content 'Bobs Cheese Shop'

        click_on 'Confirm no business'

        expect(page).to have_content 'This is a correction'
        expect(page).to have_content 'CBOARD5'
        expect(page).to have_content 'July 2018'
        expect(page).to have_content 'Thank you for reporting no business for'
        expect(page).to_not have_content 'Bobs Cheese Shop'
      end

      scenario 'user can see the current supplier name on the complete no business
        views when linked to multiple suppliers' do
        mock_user_with_multiple_suppliers_endpoint!

        visit '/'
        click_button 'sign-in'

        click_link 'History'
        click_link 'View'
        click_link 'Correct this return'

        expect(page).to have_content 'Cheese Board 5'
        expect(page).to have_content 'July 2018'
        expect(page).to have_content 'Bobs Cheese Shop'

        click_on 'Report no business'

        expect(page).to have_content 'This is a correction'
        expect(page).to have_content 'Report no business for CBOARD5'
        expect(page).to have_content 'Bobs Cheese Shop'

        click_on 'Confirm no business'

        expect(page).to have_content 'This is a correction'
        expect(page).to have_content 'CBOARD5'
        expect(page).to have_content 'July 2018'
        expect(page).to have_content 'Thank you for reporting no business for'
        expect(page).to have_content 'Bobs Cheese Shop'
      end
    end

    context 'when the latest submission is a no business' do
      before do
        mock_completed_task_with_no_business_endpoint!
      end

      scenario 'user cannot correct a no business with no business' do
        mock_user_endpoint!

        visit '/'
        click_button 'sign-in'

        click_link 'History'
        click_link 'View'
        click_link 'Correct this return'

        expect(page).to_not have_content 'Report no business'
      end
    end
  end

  context 'when submission correction is not enabled' do
    around(:each) do |example|
      ClimateControl.modify CORRECTION_RETURNS_ENABLED: nil do
        example.run
      end
    end

    before do
      mock_completed_task_endpoint!
    end

    scenario 'user cannot correct a submission' do
      mock_user_endpoint!

      visit '/'
      click_button 'sign-in'

      click_link 'History'
      click_link 'View'

      expect(page).to_not have_content 'Correct this return'
    end
  end
end
