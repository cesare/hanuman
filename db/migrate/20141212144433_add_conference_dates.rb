class AddConferenceDates < ActiveRecord::Migration
  def change
    add_column :conferences, :begins_at, :datetime, null: false
    add_column :conferences, :ends_at, :datetime, null: false
  end
end
