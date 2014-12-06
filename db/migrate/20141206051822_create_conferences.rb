class CreateConferences < ActiveRecord::Migration
  def change
    create_table :conferences do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.boolean :published, null: false, default: false
      t.timestamps
    end
  end
end
