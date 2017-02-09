class FriendsController < ApplicationController
  def index
    @group_rooms = current_user.rooms.groups
    @friend_users = current_user.following
  end
end
