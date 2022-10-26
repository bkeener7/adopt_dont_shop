require 'rails_helper'

RSpec.describe 'the applicants index' do
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
    PetApplication.create!(pet: @pet_1, applicant: @applicant2)
    PetApplication.create!(pet: @pet_3, applicant: @applicant2)
    PetApplication.create!(pet: @pet_1, applicant: @applicant3)
  end

  it 'shows all current applicants with links to their applicant page' do
    visit '/applicants'

    expect(page).to have_link(@applicant1.name)
    expect(page).to have_link(@applicant2.name)
    expect(page).to have_link(@applicant3.name)
    expect(page).to have_content(@applicant1.status)
    expect(page).to have_content(@applicant2.status)
    expect(page).to have_content(@applicant3.status)

    click_on @applicant1.name

    expect(current_path).to eq("/applicants/#{@applicant1.id}")
  end
end
