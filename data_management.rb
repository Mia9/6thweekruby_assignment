require 'sinatra'
require 'sinatra/activerecord'
require_relative 'models/movie'
require 'csv'

class DataManager
	def self.load_movie(filename)

		CSV.foreach(filename, headers: true) do |row|
			movie = Movie.create(
				title: row[0],
				description: row[1],
                director: row[2],
                publication_year: row[3],
                runtime: row[4],
                genre: row[5]
				)
		end
	end		
end

DataManager.load_movie('public/imdb_top_1000.csv')