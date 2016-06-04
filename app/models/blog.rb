class Blog < ActiveRecord::Base

  validates :name, presence: true, length: {in: 2..30}
  validates :body, presence:true, length: {minimum: 10}

  belongs_to :user
  has_many :articles
end
