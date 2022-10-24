require 'rails_helper'

RSpec.describe 'applicants' do
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

  describe 'applicants show page' do
    it 'shows the information of the applicant' do
      visit "/applicants/#{@applicant2.id}"

      expect(page).to have_content('Bruce Wayne')
      expect(page).to have_content('1007 Mountain Drive')
      expect(page).to have_content('Gotham')
      expect(page).to have_content('New Jersey')
      expect(page).to have_content(07105)
      expect(page).to have_content('I love bats(and dogs)!')

      expect(page).to_not have_content('Diana Prince')
      expect(page).to_not have_content('Hughie Campbell')
    end

    it 'shows the names of all pets applicant applied for with links to their show page' do
      visit "/applicants/#{@applicant2.id}"

      expect(page).to have_content('Lucille Bald')
      expect(page).to have_content('Beethoven')

      expect(page).to have_link(@pet_1.name, href: "/pets/#{@pet_1.id}")
      expect(page).to have_link(@pet_3.name, href: "/pets/#{@pet_3.id}")
    end

    it 'shows the applicants status' do
      visit "/applicants/#{@applicant2.id}"

      expect(page).to have_content('In Progress')
    end

    it 'allows pets to be added by name to application before submitting' do
      visit "/applicants/#{@applicant2.id}"

      expect(page).to have_button('Search')
      expect(page).to_not have_content('Lobster')

      fill_in('Search', with: 'Lobster')
      click_on('Search')

      expect(current_path).to eq("/applicants/#{@applicant2.id}")
      expect(page).to have_link('Lobster', href: "/pets/#{@pet_2.id}")
    end

    it 'shows an adopt this pet button on searched pets that adds to want to adopt on application' do
      visit "/applicants/#{@applicant2.id}"
      fill_in('Search', with: 'Lobster')
      click_on('Search')

      expect(page).to have_button('Adopt Lobster!')

      click_on('Adopt Lobster!')

      expect(current_path).to eq("/applicants/#{@applicant2.id}")
      expect(page).to have_link('Lobster', href: "/pets/#{@pet_2.id}")
      expect('Lobster').to_not appear_before('Pets I want to adopt:')
    end

    it 'submits application and updates application status to "Pending"' do
      visit "/applicants/#{@applicant2.id}"

      fill_in('Search', with: 'Lobster')
      click_on('Search')
      click_on('Adopt Lobster!')

      fill_in('Why I Would Be a Good Pet Parent:', with: 'I love bats(and dogs)!')
      click_on('Submit Application')

      expect(page).to have_content('Pending')
      expect(page).to_not have_content('Search pets to adopt:')
    end

    it 'does not show sumbit application section when no pets are added' do
      visit "/applicants/#{@applicant1.id}"

      expect(page).to_not have_content('Why I Would Be a Good Pet Parent')
      expect(page).to_not have_button('Submit Application')
    end

    it 'returns partial matches on pet names search' do
      visit "/applicants/#{@applicant2.id}"
      fill_in('Search', with: 'Lob')
      click_on('Search')

      expect(page).to have_content('Lobster')
      expect(page).to have_content('Lobo')
    end

    it 'has a case insensitive pet names search' do
      shelter = Shelter.create!(name: 'Boulder shelter', city: 'Boulder, CO', foster_program: false, rank: 9)
      pet_5 = Pet.create!(adoptable: true, age: 2, breed: 'pekingese', name: 'Mr. LoBsTeR', shelter_id: shelter.id)
      pet_6 = Pet.create!(adoptable: true, age: 4, breed: 'labrador retriever', name: 'LOBOMAN', shelter_id: shelter.id)

      visit "/applicants/#{@applicant2.id}"

      fill_in('Search', with: 'lOb')
      click_on('Search')

      expect(page).to have_content('Lobster')
      expect(page).to have_content('Lobo')
      expect(page).to have_content('Mr. LoBsTeR')
      expect(page).to have_content('LOBOMAN')
    end
  end
end
