module MovieNetwork
  extend ActiveSupport::Concern

  def create_network
    train = RubyFann::TrainData.new(:inputs=>[[0.3, 0.4, 0.5], [0.1, 0.2, 0.3]], :desired_outputs=>[[0.7], [0.8]])
    fann = RubyFann::Standard.new(:num_inputs=>4, :hidden_neurons=>[2, 8, 4, 3, 4], :num_outputs=>1)
    fann.train_on_data(train, 1000, 10, 0.1)
  end

  def search_movie(link)
    html = Nokogiri::HTML(HTTParty.get(link))
    movie_prediction_model(html)
  end

  def image(html)
    html.at("div.poster img")[:src]
  end

  def title(html)
    html.search("div.title_wrapper h1").text
  end

  def year(html)
    html.search("div.title_wrapper h1 a").text
  end

  def director(html)
    html.search("div.credit_summary_item span[itemprop='director'] span").text
  end

  def duration(html)
    html.search("time[itemprop='duration']").text.split("\n").last
  end

  def actors(html)
    actors = []
    tables = html.css("table.cast_list")
    actors =  tables.map {|table| table.css('span').to_s.split('</span><span class="itemprop" itemprop="name">') }
    actors = actors.first.map { |actor| actor.split('<span class="itemprop" itemprop="name">').last }
    actors.take(4)
  end

  def genres(html)
    genres = []
    table = html.search("div.title_wrapper div.subtext span[itemprop='genre']")
    genres = table.map {|genre| genre.text }
  end

  def movie_prediction_model(html)
    {
      poster: image(html),
      title: title(html),
      director: director(html),
      year: year(html),
      duration: duration(html),
      actors: actors(html),
      genres: genres(html)
    }
  end
end
