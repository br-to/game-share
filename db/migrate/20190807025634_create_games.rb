class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.string :title, index: true
      t.integer :user_id, index: true
      t.string :picture

      t.timestamps
    end
  end
end
