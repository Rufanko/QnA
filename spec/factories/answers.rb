FactoryBot.define do
  factory :answer do
    body { "zxc" }
    association :author, factory: :user
    question
    trait :invalid do
      body {nil}
    end
  end
end
