# == Schema Information
#
# Table name: messages
#
#  id         :integer          not null, primary key
#  content    :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  room_id    :integer          not null
#  deleted_at :integer
#  user_id    :integer          not null
#

class Message < ApplicationRecord
  acts_as_paranoid
  belongs_to :room
  belongs_to :user
  
  validates :content, presence: true, length: { maximum: 2048 }
  validates :user_id, presence: true
  
  after_create_commit { MessageBroadcastJob.perform_later self }
  
  scope :order_for_chat_room, -> {
    order("created_at ASC")
  }
  
  def room
    Room.unscoped{ super }
  end
end
