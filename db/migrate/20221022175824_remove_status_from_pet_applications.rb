class RemoveStatusFromPetApplications < ActiveRecord::Migration[5.2]
  def change
    remove_column :pet_applications, :status, :string
  end
end
