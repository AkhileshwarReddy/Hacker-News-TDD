FactoryBot.define do
  factory :comment do
    parent_comment_id { nil }
    content { Faker::Lorem.paragraph(sentence_count: (1..10)) }
    upvotes { 1 }
  end
end
