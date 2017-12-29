class AddTypeToStarts < ActiveRecord::Migration[5.1]
  def change
    add_column :starts, :features, :string
  end
end
