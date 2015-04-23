require 'faker'

# Create Users
 10.times do
   user = User.new(
     name:     Faker::Name.name,
     email:    Faker::Internet.email,
     password: Faker::Lorem.characters(10)
   )
   user.skip_confirmation!
   user.save!
 end
 users = User.all

 # Create Wikis
 100.times do
    wiki = Wiki.create!(
    user:   users.sample,
    title:  Faker::Lorem.sentence,
    body:   Faker::Lorem.paragraph
   )
 end
 wikis = Wiki.all

 # Create an admin User
 admin = User.new(
   name:  'Admin User',
   email: 'admin@example.com',
   password: 'helloworld',
   role: 'admin'
 )
 admin.skip_confirmation!
 admin.save!

 # Create a member
 member = User.new(
   name:     'Member User',
   email:    'member@example.com',
   password: 'helloworld'
 )
 member.skip_confirmation!
 member.save!

 member2 = User.new(
   name:     'Member User2',
   email:    'member2@example.com',
   password: 'helloworld'
 )
 member2.skip_confirmation!
 member2.save!
 
 puts "Seed finished"
 puts "#{User.count} users created"
 puts "#{Wiki.count} wikis created"