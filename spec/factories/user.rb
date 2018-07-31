FactoryBot.define do
  factory :user do
    name 'napoleon'
    sequence(:email) { |n| "napoleon#{n}@example.com" }
    password 'napoleon99'
    password_confirmation 'napoleon99'
  end

  factory :other_user, class: User do
    name 'alexander'
    email 'alexander@example.com'
    password 'alexander100'
    password_confirmation 'alexander100'
  end

  factory :admin_user, class: User do
    name 'alexander'
    email 'admin@example.com'
    password 'admin100'
    password_confirmation 'admin100'
    admin true
  end
end
