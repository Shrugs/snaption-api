class RenameGroupToGame < ActiveRecord::Migration[5.0]
  def change
    rename_table :groups, :games
    rename_column :groupings, :group_id, :game_id
  end
end
