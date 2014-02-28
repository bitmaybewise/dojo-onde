# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :email do |i| 
    "fulano#{i}@dojoonde.com.br"
  end

  factory :user do
    name  "Fulano de Tal"
    email
    password "123456"
    password_confirmation  "123456"
  end
end
