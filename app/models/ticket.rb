class Ticket < ApplicationRecord
  
  scope :most_recent, -> { order(id: :desc)}

end
