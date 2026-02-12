FactoryBot.define do
  factory :industry do
    sequence(:name) { |n| "Ngành nghề #{n}" }
  end
end
