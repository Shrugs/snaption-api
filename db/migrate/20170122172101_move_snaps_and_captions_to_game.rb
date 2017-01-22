class MoveSnapsAndCaptionsToGame < ActiveRecord::Migration[5.0]
  def change

    remove_column :snaps, :grouping_id
    change_table :snaps do |t|
      t.belongs_to :user
      t.belongs_to :game
    end

    remove_column :captions, :grouping_id
    change_table :captions do |t|
      t.belongs_to :user, null: true
      t.belongs_to :game
    end
  end
end
