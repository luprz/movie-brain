class CreateGenreVotes < ActiveRecord::Migration
  def change
    create_table :genre_votes do |t|
      t.integer :genre_id
      t.integer :output

      t.timestamps null: false
    end
  end
end
