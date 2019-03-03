# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# binding.pry

print '~ destroying'.red
Race.destroy_all
print '.'.red
Kit.destroy_all
print '.'.red
User.destroy_all
print '.'.red
puts 'done'.blue

url = "https://uifaces.co/api?random&limit=22"
people = JSON.parse(open(url,"X-API-KEY" => ENV['XAPIKEY']).read)
people.map { |person| person['photo']="https://#{person['photo'].split('://')[1]}" }

print 'creating special'.green
User.create!(email: 'admin@lewagon.com',first_name: 'Dmitry',last_name: 'lewagon', nickname: '👨‍💻dima', profile_type: 'junior', occupation: 'software engineer', photo:people[0]["photo"], password: '123123', points: 50000, age: 30, nationality: 'israel')
print '.admin.'.green
User.create!(email: 'user@lewagon.com',first_name: 'Roni',last_name: 'lewagon', nickname: 'Ronibaba', profile_type: 'junior', occupation: 'software engineer', photo:people[1]["photo"], password: '123123', points: 80000, age: 20, nationality: 'israel')
print '.user.'.green
puts 'done'.blue

print 'creating users'.green



i = 2
20.times do
  print '.'.green

  user = User.new(
    email:     people[i]["email"],
    # first_name:   Faker::Name.name,
    first_name:   people[i]["name"],
    last_name:   Faker::Name.last_name,
    nickname: Faker::Movies::StarWars.character,
    profile_type: 'junior',
    age: rand(13..40),
    occupation:  people[i]["position"],
    points: 0,
    nationality: 'israel',
    photo:  people[i]["photo"],
    password: "123123"
  )
  user.save!
  i += 1
end
puts 'done'.blue

print 'creating kits'.green
User.all.each do |usr|
print '.'.green
  rand(1..3).times do |el|
    Kit.create!(
    user_id: usr.id,
    name: Faker::FunnyName.name,
    description: Faker::Vehicle.manufacture,
    photo: 'https://picsum.photos/800/600/?random',
    )
  end
end
puts 'done'.blue

print 'creating races'.green
User.all.each do |usr|
  print '.'.green
  start_value = rand(2..30)
  Race.create!(
    user_id: usr.id,
    title: Faker::Lorem.sentence(3),
    start_date: Faker::Date.forward(start_value),
    category: 'Applied',)
end
puts 'done'.blue

print 'assigning participants'.green
Race.all.each do |rce|
  print '.'.green
  qty = rand(3..10)
  users = User.all.sample(qty)
  counter = 0
  qty.times do |part|
   Participant.create!(
    race_id: rce.id,
    user_id: users[counter].id,
    duration: rand(1000..60000),
    points: rand(0..100),
    status: %w[finished dropped missed].sample,
   )
   counter += 1
 end
end
puts 'done'.blue

print 'creating checkpoints'.green
Race.all.each do |rce|
  print '.'.green
  Checkpoint.create!(
    position: 1,
  race_id: rce.id,
  longitude: 34.769618,
  latitude: 32.084481,
  )
  Checkpoint.create!(
    position: 2,
  race_id: rce.id,
  longitude: 34.768127,
  latitude: 32.082198,
  )
  Checkpoint.create!(
    position: 3,
  race_id: rce.id,
  longitude: 34.766925,
  latitude: 32.078598,
  )
  Checkpoint.create!(
    position: 4,
  race_id: rce.id,
  longitude: 34.767925,
  latitude: 32.078698,
  )
  end
puts 'done'.blue
puts ''
puts 'All done!'.green
