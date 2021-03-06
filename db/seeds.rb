# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
owner1 = Owner.create({name: Faker::Name.name, email: Faker::Internet.email, password:'foo', password_confirmation: 'foo', home_state: Faker::Address.state})
owner2 = Owner.create({name: Faker::Name.name, email: Faker::Internet.email, password:'baz', password_confirmation: 'baz', home_state: Faker::Address.state})
owner3 = Owner.create({name: Faker::Name.name, email: Faker::Internet.email, password:'bar', password_confirmation: 'bar', home_state: Faker::Address.state})

ace = Owner.create({name: 'Ace Ventura', email: 'ace@ventura.com', password: 'alrighty', password_confirmation: 'alrighty', home_state: 'Florida', about_me: 'Allllrighty Then'})
snowball = Dog.create({name: 'Snowball', breed: 'puffy', age:'4', gender: 'Female', home_state: 'Florida', description: 'expensive.', owner: ace})

shelter1 = Shelter.create({name: Faker::Name.name, email: Faker::Internet.email, password:'bum', password_confirmation: 'bum', home_state: Faker::Address.state})
shelter2 = Shelter.create({name: Faker::Name.name, email: Faker::Internet.email, password:'bat', password_confirmation: 'bat', home_state: Faker::Address.state})
shelter3 = Shelter.create({name: Faker::Name.name, email: Faker::Internet.email, password:'bun', password_confirmation: 'bun', home_state: Faker::Address.state})

haven = Shelter.create({name: 'Haven to Home', email: 'haven@home.com', password: 'bark', password_confirmation: 'bark', home_state: 'PA', about_us: 'We help dogs!'})
dog1 = Dog.create({name: 'fido', breed: 'poodle', age: '8', gender: 'Male', home_state: Faker::Address.state, description: 'words', owner: owner1})
dog2 = Dog.create({name: 'dogga', breed: 'shepherd', age: '3', gender: 'Female', home_state: Faker::Address.state, description: 'other words', owner: owner1})
dog3 = Dog.create({name: 'fido', breed: 'poodle', age: '2', gender: 'Male', home_state: Faker::Address.state, description: 'bark', shelter: haven})
dog4 = Dog.create({name: 'oscar', breed: 'beagle', age: '5', gender: 'Male', home_state: Faker::Address.state, description: 'woof', shelter: shelter1})
dog5 = Dog.create({name: 'penny', breed: 'hound', age: '9', gender: 'Female', home_state: Faker::Address.state, description: 'woof', shelter: haven})
dog6 = Dog.create({name: 'herman', breed: 'bulldog', age: '4', gender: 'Male', home_state: Faker::Address.state, description: 'woof', shelter: shelter2})
