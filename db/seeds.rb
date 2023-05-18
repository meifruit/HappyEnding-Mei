# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'open-uri'
require 'nokogiri'
puts "cleaning users and bookings..."
Booking.destroy_all
User.destroy_all

gender = ["male", "female"]
title_service = ["Boyfriend", "Girlfriend", "Soulmate", "Datemate", "Datefusion", "Heartsync", "LoveHaven", "RomanceRevolution"]
location = ["Shibuya, Tokyo", "Roppongi, Tokyo", "Shinjuku, Tokyo", "Okinawa", "Osaka", "Kyoto", "Hiroshima"]

User.create(
    name: "John Doe",
    interest: "Writing",
    location: "Meguro,Tokyo",
    sex: "male",
    description: Faker::Quote.most_interesting_man_in_the_world,
    age: rand(18..50),
    email: "john@email.com",
    password: "123456"
  )

5.times do
  user = User.create!(
    name: Faker::Name.name,
    interest: Faker::Hobby.activity,
    location: location.sample,
    sex: gender.sample,
    description: Faker::Quote.most_interesting_man_in_the_world,
    age: rand(18..50),
    email: Faker::Internet.email,
    password: "123456"
  )

  puts "created #{User.count} users!"

  service = Service.new(
    user: user,
    title: title_service.sample,
    description: user.description,
    price: rand(100..500)
  )
  5.times do
    url = 'https://this-person-does-not-exist.com/en'
    doc = Nokogiri::HTML(URI.open(url).read)
    src = doc.search('#avatar').first['src']
    photo_url = "https://this-person-does-not-exist.com#{src}"
    file = URI.open(photo_url)
    service.photos.attach(io: file, filename: 'user.png', content_type: 'image/png')
    service.save
  end
end

puts "created #{Service.count} services!"

Service.all.each do |service|
  rand(1..3).times do
    booking = Booking.create!(
      user: User.where.not(id: service.user).sample,
      service: service,
      status: "pending",
      start_date: Date.today + rand(1..3),
      end_date: Date.today + rand(4..6)
    )
  end
end

puts "created #{Booking.count} bookings!"
