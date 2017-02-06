class Room < ApplicationRecord
  has_many :messages
  
  validates :title, length: { maximum: 100 }
end
