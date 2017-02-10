# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  failed_attempts        :integer          default("0"), not null
#  unlock_token           :string
#  locked_at              :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string           not null
#  deleted_at             :integer
#

class User < ApplicationRecord
  acts_as_paranoid
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  after_initialize :set_default_value
  
  has_many :user_rooms
  has_many :rooms, through: :user_rooms
  has_many :follows_from, class_name: Follow, foreign_key: :from_user_id, dependent: :destroy
  has_many :follows_to,   class_name: Follow, foreign_key: :to_user_id,   dependent: :destroy
  has_many :following_with_blocked, through: :follows_from, source: :to_user
  has_many :followed_with_blocked,  through: :follows_to,   source: :from_user
  
  validates :name, presence: true
  
  def room_with(user)
    self.rooms.where(is_group: false)
              .joins(:users)
              .find_by('users.id = ? and rooms.participants = 2', user.id)
  end
  
  def recommend_users
    self.followed - self.mutual_following - self.blocked_users
  end
  
  def mutual_following
    self.following & self.followed
  end
  
  # TODO テーブルの取得吟味（following・followed・block_users）
  def following
    self.follows_from.where(is_blocked: false).map{|model| model.to_user }
  end
  
  def followed
    self.follows_to.where(is_blocked: false).map{|model| model.from_user }
  end
  
  def blocked_users
    self.follows_from.where(is_blocked: true).map{|model| model.to_user }
  end
  
  def follow(user)
    self.follows_from.create(to_user_id: user.id)
  end
  
  def unfollow(user)
    self.follows_from.find_by(to_user_id: user.id).destroy
  end
  
  def block(user)
    self.follows_from.find_by(to_user_id: user.id).block
  end
  
  def unblock(user)
    self.follows_from.find_by(to_user_id: user.id).unblock
  end
  
  def following?(user)
    following.include?(user)
  end
  
  def followed_by?(user)
    followed.include?(user)
  end
  
  def blocked?(user)
    follows = self.follows_from.find_by(to_user_id: user.id)
    return false unless follows
    
    follows.is_blocked?
  end
  
  private
  
  def set_default_value
    self.name ||= self.email.split('@')[0]
  end
end
