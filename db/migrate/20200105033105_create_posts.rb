class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.text :content, null: false
      t.references :user, index: true, foreign_key: true
      t.json :images, null: false

      t.timestamps
    end
    add_index :posts, [:user_id, :created_at]
  end
end
