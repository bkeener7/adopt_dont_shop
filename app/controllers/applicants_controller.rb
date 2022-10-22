class ApplicantsController < ApplicationController
  def show
    @applicant = Applicant.find(params[:id])
    # require 'pry'; binding.pry
  end
end