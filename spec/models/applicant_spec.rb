require 'rails_helper'

RSpec.describe Applicant, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zipcode }
    it { should validate_numericality_of :zipcode }
    it { should validate_presence_of :status }
  end

  describe 'relationships' do
    it { should have_many :pet_applications }
    it { should have_many(:pets).through(:pet_applications) }
  end

  describe 'pet_count' do
    it 'counts the number of pets an applicant has applied for' do
      shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
      pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
      pet_3 = Pet.create!(adoptable: false, age: 2, breed: 'saint bernard', name: 'Beethoven', shelter_id: shelter.id)
      applicant2 = Applicant.create!(name: 'Bruce Wayne', address: '1007 Mountain Drive', city: 'Gotham', state: 'New Jersey', zipcode: 07105, description: 'I love bats(and dogs)!', status: 'In Progress')
      applicant3 = Applicant.create!(name: 'Hughie Campbell', address: '175 Vought Ave', city: 'New York City', state: 'New York', zipcode: 10282, description: 'Cats rule!', status: 'Pending')
      pet_application1 = PetApplication.create!(pet: pet_1, applicant: applicant2)
      pet_application2 = PetApplication.create!(pet: pet_3, applicant: applicant2)
      pet_application3 = PetApplication.create!(pet: pet_1, applicant: applicant3)

      expect(applicant2.pet_count).to eq(2)
      expect(applicant3.pet_count).to eq(1)
    end
  end

end
