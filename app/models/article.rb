class Article < ActiveRecord::Base
  
  validates :name, presence: true, length: {in: 2..30}
  validates :body, presence:true, length: {minimum: 10}

  scope :ordered, -> {order(created_at: :desc)}
  scope :followed, -> (current){joins(:user => [:follows]).where(follows: {follower_id: current})}

 


  belongs_to :user
  belongs_to :blog



end
