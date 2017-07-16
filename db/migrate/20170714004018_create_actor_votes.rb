class CreateActorVotes < ActiveRecord::Migration
  def change
    create_table :actor_votes do |t|
      t.integer :actor_id
      t.integer :output

      t.timestamps null: false
    end
  end
end
