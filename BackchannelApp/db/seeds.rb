# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
    User.create(:username => "Super", :password => "password", :role => "Super Administrator")
    User.create(:username => "Anonymous", :password => "password", :role => "Administrator")
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
