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
  
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>", face: "50x50!" }, default_url: "http://placehold.it/50x50"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  # scope :followers, ->  (current) { includes(:follows).where(follows: {follower_id: current})}

  scope :no_followed, -> (current,params) { where.not(id: Follow.where(follower_id: current).pluck(:user_id)).where.not(id: current).where("name like ?", "%#{params}%")}

  # current = current_user.id 
  # Follow.where(user_id: current)

end




