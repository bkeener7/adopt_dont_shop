require 'rails_helper'

RSpec.describe 'admin applicants' do
  before :each do
    @shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter.id)
    @pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter.id)
    @pet_3 = Pet.create!(adoptable: false, age: 2, breed: 'saint bernard', name: 'Beethoven', shelter_id: @shelter.id)
    @pet_4 = Pet.create!(adoptable: true, age: 1, breed: 'irish wolf hound', name: 'Lobo', shelter_id: @shelter.id)
    @applicant1 = Applicant.create!(name: 'Diana Prince', address: '5 Champ de Mars Ave', city: 'Denver', state: 'Colorado', zipcode: 80202, description: 'I love dogs!', status: 'In Progress')
    @applicant2 = Applicant.create!(name: 'Bruce Wayne', address: '1007 Mountain Drive', city: 'Gotham', state: 'New Jersey', zipcode: 07105, description: 'I love bats(and dogs)!', status: 'In Progress')
    @applicant3 = Applicant.create!(name: 'Hughie Campbell', address: '175 Vought Ave', city: 'New York City', state: 'New York', zipcode: 10282, description: 'Cats rule!', status: 'Pending')
    @pet_application1 = PetApplication.create!(pet: @pet_1, applicant: @applicant2)
    @pet_application2 = PetApplication.create!(pet: @pet_3, applicant: @applicant2)
    @pet_application3 = PetApplication.create!(pet: @pet_1, applicant: @applicant3)
  end

  # As a visitor
  # When I visit an admin application show page ('/admin/applications/:id')
  # For every pet that the application is for, I see a button to approve the application for that specific pet
  # When I click that button
  # Then I'm taken back to the admin application show page
  # And next to the pet that I approved, I do not see a button to approve this pet
  # And instead I see an indicator next to the pet that they have been approved
  describe 'show page' do
    it 'has an approve button next to every pet applied for' do
      visit "/admin/applicants/#{@applicant2.id}"

      within "#pet_application#{@pet_1.id}" do
        expect(page).to have_content(@pet_1.name)
        expect(page).to have_content("Approve #{@pet_1.name}")
      end
      
      within "#pet_application#{@pet_2.id}" do
        expect(page).to have_content(@pet_2.name)
        expect(page).to have_content("Approve #{@pet_2.name}")
      end
    end

    it 'has a reject button next to every pet applied for'

    it 'can decision a pet application and will not affect the same pet on a different application'
    
  end

end