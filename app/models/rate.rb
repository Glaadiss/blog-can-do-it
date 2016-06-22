class Rate < ActiveRecord::Base
  belongs_to :user
  belongs_to :comment
  belongs_to :blog
  belongs_to :article
end
