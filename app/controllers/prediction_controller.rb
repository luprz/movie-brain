class PredictionController < ApplicationController
  include MovieNetwork
  include Librery

  def index
    if params[:link]
      @movie = search_movie(params[:link])
      @director = Director.find_by_name(@movie[:director])
      @year = MovieYear.find_by_name(@movie[:year])
    end
  end

  def like
    movie = search_movie(params[:link])
    vote_year(movie, 1) if !movie[:year].blank?
    vote_director(movie, 1) if !movie[:director].blank?
    movie[:actors].each {|actor| vote_actor(actor, 1) }
    movie[:genres].each { |genre| vote_genre(genre, 1) }
    redirect_to predictions_path
  end

  def dislike
    movie = search_movie(params[:link])
    vote_year(movie, 0) if !movie[:year].blank?
    vote_director(movie, 0) if !movie[:director].blank?
    movie[:actors].each {|actor| vote_actor(actor, 0) }
    movie[:genres].each { |genre| vote_genre(genre, 0) }
    redirect_to predictions_path
  end
end
