class PetApplicationsController < ApplicationController
  def show
    @applicant = Applicant.find(params[:id])
    # @pet_application = PetApplication.find(params[:id])
  end
end
