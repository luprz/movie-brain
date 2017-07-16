module Librery
  extend ActiveSupport::Concern

  def random_id
    Random.rand(5024)
  end

  def movie_current(id)
    csv_text = File.read('db/movie_metadata.csv')
    movies = CSV.parse(csv_text, :headers => true)
    movies[id]
  end

  def image(html)
    html.at("div.poster img")[:src]
  end

  def actors(html)
    actors = []
    tables = html.css("table.cast_list")
    actors =  tables.map {|table| table.css('span').to_s.split('</span><span class="itemprop" itemprop="name">') }
    actors = actors.first.map { |actor| actor.split('<span class="itemprop" itemprop="name">').last }
    actors.take(4)
  end

  def movie_model(id, current)
    html = Nokogiri::HTML(HTTParty.get(current["movie_imdb_link"]))
    {
      id: id,
      poster: image(html),
      title: current["movie_title"],
      director: current["director_name"],
      year: current["title_year"],
      duration: current["duration"],
      actors: actors(html),
      genres: current["genres"].split("|"),
    }
  end

  def vote_year(movie, output)
    movie_year = MovieYear.where(name: movie[:year]).first;
    if movie_year
      MovieYearVote.create(movie_year_id: movie_year.id, output: output);
    else
      movie_year = MovieYear.create(name: movie[:year]);
      MovieYearVote.create(movie_year_id: movie_year.id, output: output);
    end
  end

  def vote_director(movie, output)
    director = Director.where(name: movie[:director]).first;
    if director
      DirectorVote.create(director_id: director.id, output: output);
    else
      director = Director.create(name: movie[:director]);
      DirectorVote.create(director_id: director.id, output: output);
    end
  end

  def vote_actor(actor, output)
    actor_current = Actor.where(name: actor).first;
    if actor_current
      ActorVote.create(actor_id: actor_current.id, output: output);
    else
      actor_current = Actor.create(name: actor);
      ActorVote.create(actor_id: actor_current.id, output: output);
    end
  end

  def vote_genre(genre, output)
    genre_current = Genre.where(name: genre).first;
    if genre_current
      GenreVote.create(genre_id: genre_current.id, output: output);
    else
      genre_current = Genre.create(name: genre);
      GenreVote.create(genre_id: genre_current.id, output: output);
    end
  end
end
