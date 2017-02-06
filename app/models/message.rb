class Message < ApplicationRecord
  validates :content, presence: true, length: { maximum: 2048 }
end
