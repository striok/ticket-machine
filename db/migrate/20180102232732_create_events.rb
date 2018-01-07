class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :name
      t.text :address
      t.decimal :price
      t.text :description
      t.timestamp :date
      t.integer :quantity

      t.timestamps
    end
  end
end
