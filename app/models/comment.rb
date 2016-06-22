class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :article
  scope :ordered, -> {order(created_at: :desc)}
  self.per_page = 5
end
