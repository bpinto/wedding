class CreateGuests < ActiveRecord::Migration
  def change
    create_table :guests do |t|
      t.string :name
      t.string :email
      t.boolean :confirmed
      t.text :companions, array: true

      t.timestamps
    end

    add_index :guests, :companions, using: 'gin'
  end
end
