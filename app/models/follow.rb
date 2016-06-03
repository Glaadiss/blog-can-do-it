class Follow < ActiveRecord::Base
  belongs_to :follower, class_name: "User"
  belongs_to :user
end
