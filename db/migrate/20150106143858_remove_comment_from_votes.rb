class RemoveCommentFromVotes < ActiveRecord::Migration
  def change
    remove_column :votes, :comment
  end
end
