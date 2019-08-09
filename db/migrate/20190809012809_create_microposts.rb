class CreateMicroposts < ActiveRecord::Migration[5.2]
  def change
    create_table :microposts do |t|
      t.text :content
      t.integer :user_id, index: true
      t.integer :game_id, index: true

      t.timestamps
    end
  end
end
