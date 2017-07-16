class CreateMovieVoteds < ActiveRecord::Migration
  def change
    create_table :movie_voteds do |t|
      t.integer :movie_id
      t.integer :output

      t.timestamps null: false
    end
  end
end
