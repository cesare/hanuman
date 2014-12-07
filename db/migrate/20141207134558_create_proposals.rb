class CreateProposals < ActiveRecord::Migration
  def change
    create_table :proposals do |t|
      t.integer :conference_id, null: false
      t.integer :person_id, null: false
      t.string :title, null: false
      t.text :summary, null: false
      t.timestamps
    end
  end
end
