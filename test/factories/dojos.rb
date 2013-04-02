# encoding: UTF-8
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :dojo do
    day         Time.now + 1.day
    local       "Faculdade X"
    info        "Sem comentários"
    gmaps_link  "http://google.com/maps"
    user
    
    to_create { |i| i.save(validate: false) }
  end
end
