class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :article
  validates :body, presence:true, length: {minimum: 2}
  scope :ordered, -> {order(created_at: :desc)}
  self.per_page = 5
end
