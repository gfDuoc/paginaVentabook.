class CreateInventories < ActiveRecord::Migration[5.2]
  def change
    create_table :inventories do |t|
      t.string :note
      t.integer :quantity
      t.integer :asked
      t.references :book, foreign_key: true
      t.references :location, foreign_key: true
      t.string :note

      t.timestamps
    end
  end
end
