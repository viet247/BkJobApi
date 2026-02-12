FactoryBot.define do
  factory :company do
    name { "Amcolab" }
    
    association :user
  end
end
