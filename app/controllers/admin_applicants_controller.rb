class AdminApplicantsController < ApplicationController
  def show
    @pet_apps = Applicant.find(params[:id]).pet_applications
  end

  def update
    pet_app = PetApplication.find(params[:app_id])
    pet_app.update(pet_app_params)

    redirect_to "/admin/applicants/#{params[:id]}"
  end

  private
  def pet_app_params
    params.permit(:applicant_id, :pet_id, :application_status)
  end
end