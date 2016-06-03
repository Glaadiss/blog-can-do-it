class Article < ActiveRecord::Base
  scope :ordered, -> {order(created_at: :desc)}
  scope :followed, -> (current){includes(:user => [:follows]).where(follows: {follower_id: current})}

  belongs_to :user
  belongs_to :blog



end
