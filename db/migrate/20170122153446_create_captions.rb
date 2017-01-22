class CreateCaptions < ActiveRecord::Migration[5.0]
  def change
    create_table :captions do |t|
      t.belongs_to :grouping
      t.string :text, null: false

      t.timestamps null: false
    end
  end
end
