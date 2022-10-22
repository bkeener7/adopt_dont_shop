class ApplicantsController < ApplicationController
  def show
    @applicant = Applicant.find(params[:id])
  end

  def new
  end

  def create
    new_applicant = Applicant.create!(applicant_params)

    redirect_to "/applicants/#{new_applicant.id}"
  end

  private
  def applicant_params
    params.permit(:name, :address, :city, :state, :zipcode, :status)
  end
end