puts 'Start inserting seed "posts" ...'
User.limit(10).each.with_index(1) do |user, index|
  post = user.posts.create(content: Faker::Hacker.say_something_smart, images: [open("#{Rails.root}/db/seeds/images/sample#{index}.png"), open("#{Rails.root}/db/seeds/images/sample#{11-index}.png")])
  puts "post#{post.id} has created!"
end
