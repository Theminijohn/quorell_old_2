FactoryBot.define do
  factory :topic do
    name { "MyString" }
    slug { "MyString" }
    quora_slug { "MyString" }
    followers_count { 1 }
    questions_count { 1 }
  end
end
