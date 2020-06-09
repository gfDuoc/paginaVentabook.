class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :user, foreign_key: true
      t.integer :seller
      t.text :status
      t.string :place
      t.string :note
      t.integer :value

      t.timestamps
    end
  end
end
