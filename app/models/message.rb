# == Schema Information
#
# Table name: messages
#
#  id         :integer          not null, primary key
#  content    :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  room_id    :integer
#

class Message < ApplicationRecord
  belongs_to :room
  
  validates :content, presence: true, length: { maximum: 2048 }
end
