# == Schema Information
#
# Table name: follows
#
#  id           :integer          not null, primary key
#  from_user_id :integer          not null
#  to_user_id   :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Follow < ApplicationRecord
  belongs_to :from_user, class_name: User, foreign_key: :from_user_id
  belongs_to :to_user, class_name: User,   foreign_key: :to_user_id
end
