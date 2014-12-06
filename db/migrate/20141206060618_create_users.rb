class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :person_id, null: false
      t.string :name, null: false
      t.string :uid, null: false
      t.string :provider, null: false
      t.timestamps
    end
  end
end
