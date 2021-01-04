FactoryBot.define do
  factory :user do
    username { Faker::Internet.user_name }
    email { Faker::Internet.free_email(name: username) }
    karma { Faker::Number.within(range: 0..999) }
    about { Faker::Lorem.paragraph(sentence_count: rand(0..10)) }
    password { User.new(password: username).encrypted_password }
  end
end
