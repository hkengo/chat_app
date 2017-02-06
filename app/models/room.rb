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
  has_many :messages
  has_many :user_rooms
  has_many :users, through: :user_rooms
  
  validates :name, length: { maximum: 100 }
  
  def title
    users = self.users
    if users.count == 1
      users[0].name
    else
      self.name.present? ? self.name : "グループ（#{users.count}人）"
    end
  end
end
