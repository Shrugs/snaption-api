class MoveToImageUrlInsteadOfPaperclip < ActiveRecord::Migration[5.0]
  def change
    remove_attachment :snaps, :image

    change_table :snaps do |t|
      t.string :image_src, null: false
    end
  end
end
