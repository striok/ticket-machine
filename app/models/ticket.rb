# == Schema Information
#
# Table name: tickets
#
#  id            :integer          not null, primary key
#  name          :string
#  seat_id_seq   :string
#  address       :text
#  price         :decimal(, )
#  email_address :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  picture_url   :string
#

class Ticket < ApplicationRecord
  
  scope :most_recent, -> { order(id: :desc)}

end
