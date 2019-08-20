class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.integer :user_id, index: true
      t.integer :review_id, index: true
      t.text :content

      t.timestamps
    end
  end
end
