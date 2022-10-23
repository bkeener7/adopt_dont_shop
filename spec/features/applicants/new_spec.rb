require 'rails_helper'

RSpec.describe 'applicants' do

  # before :each do
  #   @shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
  #   @pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter.id)
  #   @pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter.id)
  #   @pet_3 = Pet.create!(adoptable: false, age: 2, breed: 'saint bernard', name: 'Beethoven', shelter_id: @shelter.id)
  #   @applicant1 = Applicant.create!(name: 'Diana Prince', address: '5 Champ de Mars Ave', city: 'Denver', state: 'Colorado', zipcode: 80202, description: 'I love dogs!', status: 'In Progress')
  #   @applicant2 = Applicant.create!(name: 'Bruce Wayne', address: '1007 Mountain Drive', city: 'Gotham', state: 'New Jersey', zipcode: 07105, description: 'I love bats(and dogs)!', status: 'Pending')
  #   @applicant3 = Applicant.create!(name: 'Hughie Campbell', address: '175 Vought Ave', city: 'New York City', state: 'New York', zipcode: 10282, description: 'Cats rule!', status: 'Pending')
  #   @pet_application1 = PetApplication.create!(pet: @pet_1, applicant: @applicant2)
  #   @pet_application2 = PetApplication.create!(pet: @pet_3, applicant: @applicant2)
  #   @pet_application3 = PetApplication.create!(pet: @pet_1, applicant: @applicant3)
  # end

  describe 'applicants new page' do
    it 'has a link on the pets index page' do
      visit '/pets'

      expect(page).to have_link("Start an Application", :href => "/applicants/new")
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
      save_and_open_page
      expect(current_path).to eq('/applicants/new')
      expect(page).to have_content("Name can't be blank")
    end
    
  end
  
end