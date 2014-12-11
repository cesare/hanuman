class AddAdminToPeople < ActiveRecord::Migration
  def change
    add_column :people, :admin, :boolean, null: false, default: false
  end
end
