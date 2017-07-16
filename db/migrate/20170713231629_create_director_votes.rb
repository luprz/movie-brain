class CreateDirectorVotes < ActiveRecord::Migration
  def change
    create_table :director_votes do |t|
      t.integer :director_id
      t.integer :output

      t.timestamps null: false
    end
  end
end
