class ChangeZipcodeToString < ActiveRecord::Migration[5.2]
  def change
    change_column :applicants, :zipcode, :string
  end
end
