class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.integer :phone
      t.string :street
      t.string :detail
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
