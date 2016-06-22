class Blog < ActiveRecord::Base

  validates :name, presence: true, length: {in: 2..30}
  validates :body, presence:true, length: {minimum: 10}
  validates :user_id, presence: true

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>", face: "50x50!" }, default_url: "http://placehold.it/50x50"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  
  belongs_to :user
  has_many :articles
end
