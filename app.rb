require 'sinatra'
require 'sinatra/activerecord'
require 'bcrypt'
require 'sinatra/flash'
require_relative 'models/movie'
require_relative 'models/user'
require_relative 'models/review'

enable :sessions
register Sinatra::Flash


get '/' do
	erb :index
end
#-----------MOVIES-------------
# get '/' do
# 	@movies = Movie.all
# 	erb :index
# end

get '/movies' do
	@movies = Movie.all
	erb :movies
end

get '/movies/:movie_id' do  # movie details
	@movie = Movie.find(params[:movie_id])
	erb :movie
end

post '/movies/:movie_id' do
 	@movie = Movie.find(params[:movie_id])
 	erb :review
end
#------------Reviews------------------

get '/movies/add_review/:movie_id' do
	@movie = current_user.movies.find(params[:movie_id])
	erb :review
end

post '/movies/add_review/:movie_id' do
	@movie = Movie.find(params[:movie_id])
	@review = current_user.reviews.create(movie_id: params[:movie_id], content: params[:content], score: params[:score])
	if @review.save
		redirect "/movies/#{@movie.id}"
	else
		erb :review
	end
end

 #----------------PASSWORD, LOGIN, REGISTER PART-------------
 get '/register' do
	erb :register
end

post '/register' do
	@user = User.create(username: params[:username],
						password: params[:password] )
	if @user.save
		redirect '/login'
	else
		redirect '/register'
	end
end

get '/login' do
	if current_user
		flash[:message] = "You're logged in."
		redirect '/'
	else
		erb :login
	end
end

post '/login' do
	@user = User.find_by(username: params[:username])
	if @user && @user.authenticate(params[:password])
		session[:user_id] = @user.id
		redirect '/movies'
	else
		erb :login
	end
end

def current_user
	@current_user ||= User.find_by(id: session[:user_id])
end

def user_signed_in?
	!current_user.nil?
end


post '/logout' do
	session[:user_id] = nil
	redirect '/'
end