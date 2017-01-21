class MoveApiKeyToSeparateClass < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :authentication_token

    create_table :api_keys do |t|
      t.belongs_to :user
      t.string :authentication_token, null: false

      t.timestamps null: false
    end

    add_index :api_keys, :authentication_token, unique: true
  end
end
