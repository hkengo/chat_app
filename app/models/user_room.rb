# == Schema Information
#
# Table name: user_rooms
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  room_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class UserRoom < ApplicationRecord
  belongs_to :user
  belongs_to :room
  
  validates :user_id, presence: true
  validates :room_id, presence: true
end
