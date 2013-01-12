# encoding: UTF-8
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :dojo do
    sequence(:local) { |i| "Local#{i}" }
    day Date.today
    limit_people 15
    address 'Fundo do mar, s/n'
    city 'Atlantida'
    info 'Sem comentários'

    to_create { |i| i.save(validate: false) }
  end
end
