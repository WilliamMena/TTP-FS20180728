# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user1 = User.create(name: "William", email: "William@test.com", cash: 5000, password: "password")
stock1 = Stock.create(ticker_symbol: "NFLX-test", current_value: 381.17)
Transaction.create(user: user1, stock: stock1, value_of_each: 381.15, number_of_shares: 6)
