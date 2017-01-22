class CreateGroupings < ActiveRecord::Migration[5.0]
  def change
    create_table :groupings do |t|

      t.belongs_to :user, null: false
      t.belongs_to :group, null: false

      t.timestamps null: false
    end
  end
end
