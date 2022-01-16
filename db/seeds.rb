# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts 'Generating test companies ...'
companies = 1000.times.map do
  Company.create(
    name: Faker::Company.name,
    address: Faker::Address.full_address,
    tel: Faker::PhoneNumber.phone_number
  )
end

companies = companies.compact

puts "#{companies.size} number of companies created."

puts 'Generating test users ...'
users = 10_000.times.map do
  is_agreed = [true, false].sample
  User.create(
    company: companies.sample,
    email: Faker::Internet.unique.email,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    agreement_required: is_agreed,
    confirmed_at: is_agreed ? Time.now : nil
  )
end

puts "#{users.compact.size} number of users created."
