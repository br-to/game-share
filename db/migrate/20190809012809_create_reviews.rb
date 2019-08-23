class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.text :content
      t.integer :user_id, index: true
      t.integer :game_id, index: true
      t.boolean :is_spoiled, default: false, null: false

      t.timestamps
    end
  end
end
