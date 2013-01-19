# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name      "Fulano de Tal"
    email     "fulano@dojoaonde.com.br"
    password  "123456"
  end
end
