class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :blogs
  has_many :articles

  has_many :follows
  has_many :followers, through: :follows 

  validates :name, uniqueness: true

  # scope :followers, ->  (current) { includes(:follows).where(follows: {follower_id: current})}

  scope :no_followed, -> (current) { where.not(id: Follow.where(follower_id: current).pluck(:user_id)).where.not(id: current)}

  # current = current_user.id 
  # Follow.where(user_id: current)

end
