class Article < ActiveRecord::Base
  
  validates :name, presence: true, length: {in: 2..30},  
            uniqueness: { scope: :blog_id, message: "you can't have two articles with same name"}
            
  validates :body, presence:true, length: {minimum: 10}
  validates :user_id, presence:true
  validates :blog_id, presence:true
  
  scope :ordered, -> {order(created_at: :desc)}
  scope :followed, -> (current){joins(:user => [:follows]).where(follows: {follower_id: current})}

 
  self.per_page = 5
  has_many :comments
  belongs_to :user
  belongs_to :blog



end
