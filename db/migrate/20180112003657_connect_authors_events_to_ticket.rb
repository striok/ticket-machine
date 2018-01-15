class ConnectAuthorsEventsToTicket < ActiveRecord::Migration[5.1]
  def change
    add_column :tickets, :author_id, :integer
    add_index :tickets, :author_id
    add_column :tickets, :event_id, :integer
    add_index :tickets, :event_id
    add_column :tickets, :ticket_counter, :integer
  end
end
