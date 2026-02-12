FactoryBot.define do
  factory :job do
    sequence(:title) { |n| "Lập trình viên Ruby # {n}" }
    description {"Lap trinh vien Ruby - Back end"}
    salary { 1000.50 }

    association :city
    association :company
    association :industry
  end
end
