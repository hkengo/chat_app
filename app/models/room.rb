# == Schema Information
#
# Table name: rooms
#
#  id           :integer          not null, primary key
#  name         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  deleted_at   :integer
#  participants :integer          not null
#  is_group     :boolean          default("f"), not null
#

class Room < ApplicationRecord
  acts_as_paranoid
  
  before_validation :set_participants
  
  has_many :messages
  has_many :user_rooms
  has_many :users, through: :user_rooms
  
  validates :name, length: { maximum: 100 }
  validates :participants, presence: true
  
  scope :groups, -> {
    where('participants > 2')
  }
  
  scope :one_on_one, -> {
    where(participants: 2)
  }
  
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
    self.is_group? ? title + "（#{user_count}）" : title
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
  
  private
  
  def set_participants
    current_participants = self.users.count
    unless self.participants == current_participants
      self.participants = current_participants
    end
  end
end
