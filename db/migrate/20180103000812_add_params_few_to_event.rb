class AddParamsFewToEvent < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :event_picture_url, :string
    add_column :events, :purchase_counter, :integer, default: 0
  end
end
