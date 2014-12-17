class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :proposal_id, null: false
      t.integer :person_id, null: false
      t.text :comment, null: true
      t.timestamps
    end
  end
end
