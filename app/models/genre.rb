class Genre < ActiveRecord::Base
  has_many :genre_votes

  def self.ranking
    ranking = []
    self.all.each do |genre|
      ranking.push [genre.name, genre.prediction, genre.valoration]
    end
    ranking.sort! { |a,b| a.second <=> b.second } .reverse
  end

  def inputs
    inputs = []
    self.genre_votes.each {|v| inputs << [v.genre_id] }
    inputs
  end

  def outputs
    inputs = []
    self.genre_votes.each {|v| inputs << [v.output] }
    inputs
  end

  def prediction
    net = RubyFann::Standard.new(:num_inputs=>1, :hidden_neurons=>[2], :num_outputs=>1)
    train_data = RubyFann::TrainData.new(:inputs=>self.inputs, :desired_outputs=>self.outputs)
    net.train_on_data(train_data, 100000, 10, 0.1)
    net.run([self.id]).first
  end

  def valoration
    if self.prediction >= 0.7
      "success"
    elsif self.prediction >= 0.5 && self.prediction < 0.7
      "warning"
    else
      "danger"
    end
  end
end
