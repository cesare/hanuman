class AddProposalDeadlineToConferences < ActiveRecord::Migration
  def change
    add_column :conferences, :proposal_deadline, :datetime, null: false
  end
end
