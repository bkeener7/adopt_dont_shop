require 'rails_helper'

RSpec.describe 'application' do
  xit 'shows the name of the applicant' do
    shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
    pet_3 = Pet.create!(adoptable: false, age: 2, breed: 'saint bernard', name: 'Beethoven', shelter_id: shelter.id)
    applicant = Applicant.create!(name: 'Tom Jones', address: '123 Main St', city: 'Denver', state: 'Colorado', zipcode: 80_202, description: 'I love dogs!')
    application = Application.create!(status: 'In Progress', applicant_id: applicant.id, pet_id: pet_1.id)

    visit "/applications/#{applications.id}"
    expect(page).to have_content('Tom Jones')
  end
end
