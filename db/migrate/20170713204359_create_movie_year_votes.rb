class CreateMovieYearVotes < ActiveRecord::Migration
  def change
    create_table :movie_year_votes do |t|
      t.integer :movie_year_id
      t.integer :output

      t.timestamps null: false
    end
  end
end
