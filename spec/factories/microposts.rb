FactoryBot.define do
  factory :micropost do
    content "MyText"
    user
    created_at 2.hours.ago
  end

  factory :recent, class: Micropost do
    content "This is the recent micropost"
    user
    created_at Time.zone.now
  end

  factory :old, class: Micropost do
    content "This is the old micropost"
    user
    created_at 10.years.ago
  end
end
