# == Schema Information
#
# Table name: rooms
#
#  id                        :integer          not null, primary key
#  name                      :string
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  deleted_at                :integer
#  participants              :integer          default("0"), not null
#  is_group                  :boolean          default("f"), not null
#  latest_message_created_at :integer
#

class Room < ApplicationRecord
  acts_as_paranoid
  
  before_create :set_latest_message_created_at
  before_save :set_participants
  
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
  
  scope :newest, -> {
    order("latest_message_created_at DESC")
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
    is_exist = !!self.users.find_by(email: user.email)
    
    is_group ? !is_exist : (!is_exist && self.users.count < 2)
  end
  
  def add_user(user)
    self.users << user if can_add?(user)
  end
  
  private
  
  def set_latest_message_created_at
    self.latest_message_created_at = self.created_at
  end
  
  def set_participants
    self.participants = self.users.count
  end
end
