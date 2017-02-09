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
#  is_blocked   :boolean          default("f"), not null
#

require 'test_helper'

class FollowTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
