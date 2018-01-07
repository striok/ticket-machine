class AddBirthDateToAuthor < ActiveRecord::Migration[5.1]
  def change
    add_column :authors, :birth_date, :timestamp
  end
end
