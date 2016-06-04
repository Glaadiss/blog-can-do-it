class Follow < ActiveRecord::Base

  validates :user_id, presence: true
  validates :follower_id, presence:true
  validate :cant_be_same

  scope :follows, -> (current) { where(follower_id:current)}

  belongs_to :follower, class_name: "User", foreign_key: 'follower_id'
  belongs_to :user 

  def cant_be_same
    errors.add(:same_params, " Nie można zasubskrybować samego siebie :)")if self.user_id == self.follower_id
  end
end
