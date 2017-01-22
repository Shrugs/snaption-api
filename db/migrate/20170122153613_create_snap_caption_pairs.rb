class CreateSnapCaptionPairs < ActiveRecord::Migration[5.0]
  def change
    create_table :snap_caption_pairs do |t|

      t.belongs_to :game

      t.references :snap
      t.references :caption

      t.timestamps null: false
    end
  end
end
