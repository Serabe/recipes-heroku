FactoryGirl.define do
  factory :step do
    sequence(:position) { |n| n }
    instruction "MyText"
  end
end
