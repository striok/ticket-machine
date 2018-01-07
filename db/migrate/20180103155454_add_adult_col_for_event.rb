class AddAdultColForEvent < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :adult, :boolean, default: false
  end
end
