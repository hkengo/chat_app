# == Schema Information
#
# Table name: rooms
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Room < ApplicationRecord
  acts_as_paranoid
  has_many :messages
  has_many :user_rooms
  has_many :users, through: :user_rooms
  
  validates :name, length: { maximum: 100 }
  
  def title
    users = self.users
    user_count = users.count
    
    case user_count
    when 1
      title = users[0].name
    when 2
      title = users[1].name
    else
      title = self.name.present? ? self.name : "グループ"
    end
    title + "（#{user_count}）"
  end
  
  def channel
    "room_channel_#{self.id}"
  end
  
  def can_add?(user)
    !self.users.find_by(email: user.email)
  end
  
  def add_user(user)
    self.users << user if can_add?(user)
  end
end
