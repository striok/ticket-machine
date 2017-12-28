class AddPictureUrlToTicketsTable < ActiveRecord::Migration[5.1]
  def change
    add_column :tickets, :picture_url, :string
  end
end
