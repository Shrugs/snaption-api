class AddWorkflowToGame < ActiveRecord::Migration[5.0]
  def change
    change_table :games do |t|
      t.string :workflow_state, null: false
      t.references :requested_user, index: true, foreign_key: { to_table: :users }
      t.integer :play_type, null: false, default: 0
    end
  end
end
