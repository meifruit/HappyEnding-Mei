# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Booking.destroy_all
User.destroy_all

4.times do
  user = User.create!(
    name: Faker::Name.name,
    interest: Faker::Hobby.activity,
    location: Faker::Address.full_address,
    sex: "male",
    description: Faker::Quote.most_interesting_man_in_the_world,
    age: Faker::Number.decimal_part(digits: 2),
    email: Faker::Internet.email,
    password: "123456"
  )

  service = Service.create!(
    user: user,
    title: "hello",
    description: "hello",
    price: rand(1..5)
  )
end

Service.all.each do |service|
  4.times do
    booking = Booking.create!(
      user: User.where.not(id: service.user).sample,
      service: service,
      status: "pending",
      start_date: Date.today + rand(1..3),
      end_date: Date.today + rand(4..6)
    )
  end
end
