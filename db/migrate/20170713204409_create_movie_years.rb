class CreateMovieYears < ActiveRecord::Migration
  def change
    create_table :movie_years do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
