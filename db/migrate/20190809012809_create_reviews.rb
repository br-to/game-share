class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.text :content
      t.integer :user_id, index: true
      t.integer :game_id, index: true
      t.string :netabare_digest

      t.timestamps
    end
  end
end
