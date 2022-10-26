class PetApplicationsController < ApplicationController
  def add_pet
    PetApplication.create!(pet_application_params)
    redirect_to("/applicants/#{PetApplication.last.applicant_id}")
  end

  private

  def pet_application_params
    params.permit(:applicant_id, :pet_id)
  end
end
