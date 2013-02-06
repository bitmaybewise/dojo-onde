# encoding: UTF-8
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :dojo do
    day Date.today
    limit_people 15
    info 'Sem comentários'

    after(:create)  {|dojo| FactoryGirl.create(:local, dojo: dojo) }
    after(:build)  {|dojo| dojo.local = FactoryGirl.build(:local, dojo: dojo) }
    to_create { |i| i.save(validate: false) }
  end
end
