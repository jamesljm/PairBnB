# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

ActiveRecord::Base.transaction do
    10.times {
        User.create(email: Faker::Internet.email, password: 123, name: Faker::HarryPotter.character)
    }
end

uids = []
User.all.each {|u| uids << u.id}

ActiveRecord::Base.transaction do
    40.times do
        Listing.create(title: Faker::Address.community, kitchen: rand(0..1), amenities: ["gym", "pool", "sauna", "toilets"].sample(rand(0..4)), user_id: uids.sample)
    end
end