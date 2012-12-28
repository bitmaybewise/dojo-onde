# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :dojo do
    sequence(:local) { |i| "Faculdade#{i}" }
    day   Date.today
    city  'Atlantida'
  end
end
