# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ActiveRecord::Base.transaction do
  User.create!(username: "daxwann", password: "password")
  User.create!(username: "phoebe", password: "starwars")
  User.create!(username: "jd", password: "scrubs")
  User.create!(username: "eve", password: "killing")

  Cat.create!(name: "Charlie", birth_date: "2017-08-07", sex: "M", color: "orange", description: "Quiet and shy", user_id: 1)
  Cat.create!(name: "Stella", birth_date: "2018-01-03", sex: "F", color: "black", description: "Sassy and fast", user_id: 2)
  Cat.create!(name: "Hubert", birth_date: "2016-04-19", sex: "M", color: "brown", description: "Loves food", user_id: 3)
  Cat.create!(name: "Zeus", birth_date: "2019-02-28", sex: "M", color: "white", description: "Likes to run", user_id: 4)

  CatRentalRequest.create!(cat_id: 1, start_date: "2019-05-20", end_date: "2019-08-20", status: "APPROVED")
  CatRentalRequest.create!(cat_id: 2, start_date: "2019-05-20", end_date: "2019-06-20")
  CatRentalRequest.create!(cat_id: 3, start_date: "2019-06-20", end_date: "2019-07-20", status: "DENIED")
  CatRentalRequest.create!(cat_id: 4, start_date: "2019-06-01", end_date: "2019-08-09", status: "APPROVED")
  end
