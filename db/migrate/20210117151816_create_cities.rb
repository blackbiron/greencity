class CreateCities < ActiveRecord::Migration[6.1]
  def change
    create_table :cities do |t|
      t.references :country, null: false, foreign_key: true
      t.string :name
      t.string :original_name
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :cities, :deleted_at
  end
end
