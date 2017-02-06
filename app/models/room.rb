class Room < ApplicationRecord
  validates :title, length: { maximum: 50 }
end
