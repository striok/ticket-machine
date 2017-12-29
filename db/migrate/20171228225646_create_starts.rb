class CreateStarts < ActiveRecord::Migration[5.1]
  def change
    create_table :starts do |t|
      t.string :picture_url
      t.string :title

      t.timestamps
    end
  end
end
