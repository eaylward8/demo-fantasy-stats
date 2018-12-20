# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

names = %w[Earl Craig Ray Wallie Dom Herschel Neil Wade Jasper Turk Ron Spense Monty Malcolm Lew Amos]

names.each do |name|
  Owner.where(name: name).first_or_create!
end

[*2012..2018].each do |year|
  Season.where(year: year).first_or_create!
end
