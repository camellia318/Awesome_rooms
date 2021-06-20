class CreateRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :rooms do |t|
      t.bigint :owner_id
      t.string :name
      t.string :adress
      t.integer :price
      t.text :description
      t.string :image

      t.timestamps
    end
    
    add_index :rooms, :owner_id
  end
end
