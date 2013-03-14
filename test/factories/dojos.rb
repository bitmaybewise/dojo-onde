# encoding: UTF-8
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :dojo do
    day Date.today
    local "Faculdade X"
    limit_people 15
    info "Sem comentários"

    to_create { |i| i.save(validate: false) }
  end
end
