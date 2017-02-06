class Message < ApplicationRecord
  belongs_to :room
  
  validates :content, presence: true, length: { maximum: 2048 }
end
