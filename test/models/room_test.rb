# == Schema Information
#
# Table name: rooms
#
#  id           :integer          not null, primary key
#  name         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  deleted_at   :integer
#  participants :integer          default("0"), not null
#  is_group     :boolean          default("f"), not null
#

require 'test_helper'

class RoomTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
