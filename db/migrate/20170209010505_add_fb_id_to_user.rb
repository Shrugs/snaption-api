class AddFbIdToUser < ActiveRecord::Migration[5.0]
  def change
    change_table :users do |t|
      t.string :fb_id, null: false
    end
  end
end
