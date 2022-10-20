require 'rails_helper'

RSpec.describe 'applicant' do
    xit 'shows the name of the applicant' do
        visit '/applicant'
        expect(page).to have_content('Name of Applicant')
    end
end