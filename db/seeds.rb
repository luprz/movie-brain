# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'csv'

csv_text = File.read('db/movie_metadata.csv')
movies = CSV.parse(csv_text, :headers => true)

movies.each do |movie|

  movie_db = Movie.create imdb_link: movie[17]

  puts "Created #{movie[17]}"
  puts"#{movie_db.id} de #{movies.count}"
end
