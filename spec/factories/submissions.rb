FactoryBot.define do
  factory :submission do
    title { "MyString" }
    url { "MyString" }
    text { "MyText" }
    upvotes { 1 }
    references { "" }
  end
end
