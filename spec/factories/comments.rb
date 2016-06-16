FactoryGirl.define do
  factory :comment do
    user nil
    article nil
    body "MyText"
    rate 1
  end
end
