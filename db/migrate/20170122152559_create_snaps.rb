class CreateSnaps < ActiveRecord::Migration[5.0]
  def change
    create_table :snaps do |t|
      t.belongs_to :grouping
      t.attachment :image

      t.timestamps null: false
    end
  end
end
