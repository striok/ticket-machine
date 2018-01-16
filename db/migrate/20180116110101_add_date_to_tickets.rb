class AddDateToTickets < ActiveRecord::Migration[5.1]
  def change
    add_column :tickets, :date, :timestamp
  end
end
