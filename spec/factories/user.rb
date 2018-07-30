FactoryBot.define do
  factory :user do
    name 'napoleon'
    email 'napoleon@example.com'
    password 'napoleon99'
    password_confirmation 'napoleon99'
  end

  factory :other_user, class: User do
    name 'alexander'
    email 'alexander@example.com'
    password 'alexander100'
    password_confirmation 'alexander100'
  end
end
