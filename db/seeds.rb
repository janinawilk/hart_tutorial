User.create!(name:                  'Example user',
             email:                 'example@rails.com',
             password:              'foobar',
             password_confirmation: 'foobar',
             admin:                  true,
             activated:              true,
             activated_at:           Time.zone.now)

99.times do |n|
  name = Faker::Name.name
  email = Faker::Internet.unique.email
  password = 'password'
  User.create!(name:                  name,
               email:                 email,
               password:              password,
               password_confirmation: password)
end

users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.microposts.create!(content: content) }
end
