# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :retrospective do
    challenge "Fibonacci"
    positive_points ":)"
    improvement_points  ":("
    dojo
  end
end
