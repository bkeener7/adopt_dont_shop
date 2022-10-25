class PetApplication < ApplicationRecord
  belongs_to :applicant
  belongs_to :pet

  def pet_name
    pet.name
  end
end
