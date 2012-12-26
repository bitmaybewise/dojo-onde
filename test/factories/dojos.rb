# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :dojo do
    sequence(:local, 1) { |i| "Faculdade#{i}" }
    sequence(:day) { |i| Time.now - 5.days + (1.day * i) }
    city 'Atlantida'
  end
end
