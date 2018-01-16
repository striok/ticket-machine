class AddReturnToTickets < ActiveRecord::Migration[5.1]
  def change
    add_column :tickets, :is_return, :boolean, default: false
    add_column :tickets, :return_counter, :integer, default: 0
  end
end
