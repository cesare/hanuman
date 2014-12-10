class CreateStaffs < ActiveRecord::Migration
  def change
    create_table :staffs do |t|
      t.integer :conference_id, null: false
      t.integer :person_id, null: false
      t.timestamps
    end
  end
end
