class PetApplicationsController < ApplicationController
  def add_pet
    new_pet = Pet.find(params[:pet_id])
    existing_applicant = Applicant.find(params[:applicant_id])
    PetApplication.create!(pet: new_pet, applicant: existing_applicant)
    redirect_to("/applicants/#{existing_applicant.id}")
  end
end
