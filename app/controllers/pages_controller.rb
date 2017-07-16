class PagesController < ApplicationController
  include Librery

  def index
    id = Random.rand(5024)
    current = movie_current(id)
    @movie = movie_model(id, current)
  end

  def statistics
    @year_ranking = MovieYear.ranking
    @director_ranking = Director.ranking
    @actor_ranking = Actor.ranking
    @genre_ranking = Genre.ranking
  end

  def like
    movie = movie_current(params[:id].to_i);
    movie = movie_model(params[:id].to_i, movie)
    vote_year(movie, 1) if !movie[:year].blank?
    vote_director(movie, 1) if !movie[:director].blank?
    movie[:actors].each do |actor|
      vote_actor(actor, 1)
    end
    movie[:genres].each do |genre|
      vote_genre(genre, 1)
    end
    redirect_to root_path
  end

  def dislike
    movie = movie_current(params[:id].to_i);
    movie = movie_model(params[:id].to_i, movie)
    vote_year(movie, 0) if !movie[:year].blank?
    vote_director(movie, 0) if !movie[:director].blank?
    movie[:actors].each do |actor|
      vote_actor(actor, 0)
    end
    movie[:genres].each do |genre|
      vote_genre(genre, 0)
    end
    redirect_to root_path
  end

end
