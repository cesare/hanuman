class AddNotesToProposals < ActiveRecord::Migration
  def change
    add_column :proposals, :notes, :text, null: true
  end
end
