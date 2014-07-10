class AddProductToGuests < ActiveRecord::Migration
  def change
    add_column :guests, :product_id, :integer
    add_column :guests, :email_message, :text
  end
end
