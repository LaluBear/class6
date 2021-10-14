class RemoveFolloweeIdFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :followee_id, :integer
    add_column :users, :followee_id, :integer, array: true, default: nil
  end
end
