require 'rails_helper'

RSpec.describe 'the shelters index' do
  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    @pet_4 = @shelter_2.pets.create(name: 'Mr. Bigglesworth', breed: 'persian', age: 8, adoptable: true)
    @applicant1 = Applicant.create!(name: 'Diana Prince', address: '5 Champ de Mars Ave', city: 'Denver', state: 'Colorado', zipcode: 80202, description: 'I love dogs!', status: 'In Progress')
    @applicant2 = Applicant.create!(name: 'Bruce Wayne', address: '1007 Mountain Drive', city: 'Gotham', state: 'New Jersey', zipcode: 07105, description: 'I love bats(and dogs)!', status: 'In Progress')
    @applicant3 = Applicant.create!(name: 'Hughie Campbell', address: '175 Vought Ave', city: 'New York City', state: 'New York', zipcode: 10282, description: 'Cats rule!', status: 'Pending')
    @pet_application1 = PetApplication.create!(applicant_id: @applicant2.id, pet_id: @pet_1.id)
    @pet_application2 = PetApplication.create!(applicant_id: @applicant2.id, pet_id: @pet_3.id)
    @pet_application3 = PetApplication.create!(applicant_id: @applicant3.id, pet_id: @pet_1.id)
  end

  it 'sees all shelters in the system listed in reverse alphabetical order' do
    visit '/admin/shelters'

    within '#shelter_' do
      expect(@shelter_2.name).to appear_before(@shelter_3.name)
      expect(@shelter_3.name).to appear_before(@shelter_1.name)
      expect(@shelter_1.name).to_not appear_before(@shelter_2.name)
    end
  end

  it 'sees a section for shelters with the name of every shelter that has a pending application' do
    visit '/admin/shelters'

    within '#shelters_with_apps' do
      expect(page).to have_content('Aurora shelter')
      expect(page).to have_content('Fancy pets of Colorado')
      expect(page).to_not have_content('RGV animal shelter')
    end
  end
end
