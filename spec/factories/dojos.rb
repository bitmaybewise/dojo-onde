# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :dojo do
    day         Time.now + 1.day
    local       "Algum lugar aê"
    info        "Sem comentários"
    gmaps_link  "https://www.google.com/maps?q=Vit%C3%B3ria+-+Esp%C3%ADrito+Santo,+Rep%C3%BAblica+Federativa+do+Brasil&hl=pt-BR&ie=UTF8&sll=37.0625,-95.677068&sspn=40.137381,79.013672&oq=vit%C3%B3ria&hnear=Vit%C3%B3ria+-+Esp%C3%ADrito+Santo,+Rep%C3%BAblica+Federativa+do+Brasil&t=m&z=12"
    user
    to_create { |i| i.save!(validate: false) }
  end
end
