FactoryBot.define do
  factory :user do
    name 'napoleon'
    sequence(:email) { |n| "napoleon#{n}@example.com" }
    password 'napoleon99'
    password_confirmation 'napoleon99'
    activated true
    activated_at Time.zone.now
  end
  factory :user_with_microposts, class: User do
    name 'mikropostowiec'
    email 'mikropostowiec@example.com'
    password 'napoleon99'
    password_confirmation 'napoleon99'
    activated true
    activated_at Time.zone.now
    after :create do |user|
      create_list :micropost, 50, user: user
    end
  end

  factory :other_user, class: User do
    name 'alexander'
    email 'alexander@example.com'
    password 'alexander100'
    password_confirmation 'alexander100'
    activated true
    activated_at Time.zone.now
  end

  factory :admin_user, class: User do
    name 'alexander'
    email 'admin@example.com'
    password 'admin100'
    password_confirmation 'admin100'
    admin true
    activated true
    activated_at Time.zone.now
  end
end
