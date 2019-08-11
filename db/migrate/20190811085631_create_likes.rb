class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.integer :user_id, index: true, unique: true
      t.integer :game_id, index: true, unique: true
      t.integer :review_id, index: true, unique: true

      t.timestamps
    end
  end
end
