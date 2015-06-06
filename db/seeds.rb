# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#['writer', 'banned', 'moderator', 'admin'].each do |role|
#  Role.find_or_create_by({name: role})
#end
Genre.destroy_all
story = Genre.create!(name: 'Story')
poem = Genre.create!(name: 'Poetry')
scifi = Genre.create!(name: 'Sci-Fi')


p "created #{Genre.count} genres"