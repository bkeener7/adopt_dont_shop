require 'rails_helper'

RSpec.describe PetApplication, type: :model do
  describe 'relationships' do
    it { should belong_to :applicant }
    it { should belong_to :pet }
  end

  describe 'pet_name' do
    it 'returns the name of the pet from the pet application' do
      shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
      pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
      pet_3 = Pet.create!(adoptable: false, age: 2, breed: 'saint bernard', name: 'Beethoven', shelter_id: shelter.id)
      applicant2 = Applicant.create!(name: 'Bruce Wayne', address: '1007 Mountain Drive', city: 'Gotham', state: 'New Jersey', zipcode: 07105, description: 'I love bats(and dogs)!', status: 'In Progress')
      applicant3 = Applicant.create!(name: 'Hughie Campbell', address: '175 Vought Ave', city: 'New York City', state: 'New York', zipcode: 10282, description: 'Cats rule!', status: 'Pending')
      pet_application1 = PetApplication.create!(pet: pet_1, applicant: applicant2)
      pet_application2 = PetApplication.create!(pet: pet_3, applicant: applicant2)
      pet_application3 = PetApplication.create!(pet: pet_1, applicant: applicant3)

      expect(pet_application1.pet_name).to eq('Lucille Bald')
      expect(pet_application2.pet_name).to eq('Beethoven')
      expect(pet_application3.pet_name).to eq('Lucille Bald')
    end
  end
end
