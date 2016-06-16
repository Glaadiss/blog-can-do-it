FactoryGirl.define do
  factory :blog do
    name 'blog'
    body 'blog o wszystkim'
    association :user, :factory => :user
  end
end
