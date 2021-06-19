class CreateReservations < ActiveRecord::Migration[6.0]
  def change
    create_table :reservations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true, index: false
      t.date :start_date
      t.date :end_date
      t.integer :person

      t.timestamps
    end
    
    add_index :reservations, %i[room_id user_id], unique:true
  end
end
