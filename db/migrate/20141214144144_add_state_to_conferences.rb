class AddStateToConferences < ActiveRecord::Migration
  def change
    add_column :conferences, :state, :integer, null: false, default: 0
  end
end
