FactoryGirl.define do
  factory :article do
    name 'article'
    body 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Cum magni beatae inventore ad adipisci ducimus nemo, dolore, sunt voluptate necessitatibus asperiores soluta sit. Harum suscipit doloribus voluptatem expedita sed eius!'
    association :user, :factory => :user
    association :blog, :factory => :blog
  end
end
