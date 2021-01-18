class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.text :content
      t.decimal :latitude
      t.decimal :longitude
      t.references :city, null: false, foreign_key: true
      t.text :address
      t.string :session_id
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :posts, :deleted_at
  end
end
