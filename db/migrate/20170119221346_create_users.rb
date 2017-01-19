class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :display_name, null: false
      t.string :profile_image_url, null: false
      t.string :fb_access_token, null: false
      t.string :authentication_token, null: false

      t.timestamps null: false
    end

    add_index :users, :authentication_token, unique: true
  end
end
