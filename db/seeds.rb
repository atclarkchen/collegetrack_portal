# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create!(:email => 'jason.chern93@gmail.com', :password => 'password')
User.create!(:email => 'alam@collegetrack.org', :password => 'password')
User.create!(:email => 'petrduong@gmail.com', :password => 'password')
User.create!(:email => 'shinyenhuang@gmail.com', :password => 'password')
User.create!(:email => 'changwliang@gmail.com', :password => 'password')
User.create!(:email => 'hchang409@gmail.com', :password => 'password')
User.create!(:email => 'jerryuejio@gmail.com', :password => 'password')