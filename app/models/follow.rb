# == Schema Information
#
# Table name: follows
#
#  id           :integer          not null, primary key
#  from_user_id :integer          not null
#  to_user_id   :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  deleted_at   :integer
#  is_blocked   :boolean          not null
#

class Follow < ApplicationRecord
  acts_as_paranoid
  
  belongs_to :from_user, class_name: User, foreign_key: :from_user_id
  belongs_to :to_user, class_name: User,   foreign_key: :to_user_id
  
  # default_scope { where(is_blocked: false) }
  
  def block
    self.update(is_blocked: true)
  end
  
  def unblock
    self.update(is_blocked: false)
  end
end
