puts 'Start inserting seed "users" ...'
10.times do
  user = User.create(
     name: Faker::Name.name,
     email: Faker::Internet.unique.email,
     password: "password",
     password_confirmation: "password",
   )
   puts "\"#{user.name}\" has created!"
end

guest_user = User.create(
  name: 'guest',
  email: 'guest@guest',
  password: "guest",
  password_confirmation: "guest",
)
puts "\"#{guest_user.name}\" has created!"