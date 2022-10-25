require 'rails_helper'

RSpec.describe 'applicants' do
  describe 'applicants new page' do
    it 'has a link on the pets index page' do
      visit '/pets'

      expect(page).to have_link('Start an Application', href: '/applicants/new')
    end

    it 'has a form to complete a new application' do
      visit '/applicants/new'

      expect(page).to have_selector(:css, 'form')
    end

    it 'displays new application show page when form is submitted' do
      visit '/applicants/new'

      fill_in('Name', with: 'Bruce Wayne')
      fill_in('Address', with: '1007 Mountain Drive')
      fill_in('City', with: 'Gotham')
      select('NJ - New Jersey', from: 'State')
      fill_in('Zipcode', with: '17105') # Leading zeroes are being truncated by number_field form

      click_button('Submit Application')

      new_applicant = Applicant.last

      expect(current_path).to eq("/applicants/#{new_applicant.id}")
      expect(page).to have_content('Bruce Wayne')
      expect(page).to have_content('1007 Mountain Drive')
      expect(page).to have_content('Gotham')
      expect(page).to have_content('New Jersey')
      expect(page).to have_content('17105')
      expect(page).to have_content('In Progress')
    end

    it 'stays on new applications page and displays message when field(s) are incomplete' do
      visit '/applicants/new'

      fill_in('Address', with: '1007 Mountain Drive')
      fill_in('City', with: 'Gotham')
      select('NJ - New Jersey', from: 'State')
      fill_in('Zipcode', with: '17105') # Leading zeroes are being truncated by number_field form

      click_button('Submit Application')

      expect(current_path).to eq('/applicants/new')
      expect(page).to have_content("Name can't be blank")
    end
  end
end
