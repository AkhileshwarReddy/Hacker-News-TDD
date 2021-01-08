FactoryBot.define do
  factory :submission do
    title { Faker::Lorem.sentence }
    url { ["", Faker::Internet.url].sample }
    text { url.empty? ? Faker::Lorem.paragraph(sentence_count: (0..50)) : nil }
    upvotes { 1 }
    is_showhn { title.start_with?("Show HN:") }
    is_askhn { title.start_with?("Ask HN:") and url.empty? }
    is_flagged { false }
  end
end
