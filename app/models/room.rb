# == Schema Information
#
# Table name: rooms
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Room < ApplicationRecord
  has_many :messages
  
  validates :title, length: { maximum: 100 }
end
