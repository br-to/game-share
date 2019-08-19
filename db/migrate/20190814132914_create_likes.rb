class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.integer :user_id, index: true
      t.integer :review_id, index: true

      t.timestamps
    end
    add_index :likes, [:user_id, :review_id], unique: true
  end
end
