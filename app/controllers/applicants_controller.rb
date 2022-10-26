class ApplicantsController < ApplicationController
  def index
    @applicants = Applicant.all
  end

  def show
    @pets = Pet.search(params[:search]) if params[:search].present?
    @applicant = Applicant.find(params[:id])
  end

  def new; end

  def create
    @applicant = Applicant.create(applicant_params)
    if @applicant.valid?
      redirect_to "/applicants/#{@applicant.id}"
    else
      flash[:errors] = @applicant.errors.full_messages
      redirect_to '/applicants/new'
    end
  end

  def update
    applicant = Applicant.find(params[:id])
    applicant.update(applicant_params)

    redirect_to "/applicants/#{applicant.id}"
  end

  private

  def applicant_params
    params.permit(:name, :address, :city, :state, :zipcode, :status)
  end
end
