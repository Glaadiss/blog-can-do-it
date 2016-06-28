class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :blogs,  dependent: :destroy
  has_many :articles,  dependent: :destroy
  has_many :follows,  dependent: :destroy
  has_many :followers, through: :follows,  dependent: :destroy
  has_many :comments, dependent: :destroy
  devise :omniauthable, :omniauth_providers => [:facebook]

  validates :name, uniqueness: true
  
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>", face: "50x50!" }, default_url: "http://placehold.it/50x50"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  # scope :followers, ->  (current) { includes(:follows).where(follows: {follower_id: current})}

  scope :no_followed, -> (current,params) { where.not(id: Follow.where(follower_id: current).pluck(:user_id)).where.not(id: current).where("name like ?", "%#{params}%")}

  # current = current_user.id 
  # Follow.where(user_id: current)

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      user.avatar = process_uri(auth.info.image)
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
  
  def self.process_uri(uri)
     avatar_url = URI.parse(uri)
     avatar_url.scheme = 'https'
     avatar_url.to_s
  end
end




