FactoryBot.define do
  factory :comment do
    parent_comment_id { "" }
    content { "MyText" }
    upvotes { 1 }
    references { "" }
    references { "" }
  end
end
