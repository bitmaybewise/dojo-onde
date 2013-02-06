# encoding: UTF-8
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :local do
    name "Faculdade do Joãozinho"
    address "Rua qualquer"
    city "Vitória"
    state "ES"
    dojo Dojo.new
  end
end
