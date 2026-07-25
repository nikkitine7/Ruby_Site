class CreateOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.string :email
      t.string :status
      t.decimal :total
      t.string :shipping_name
      t.text :shipping_address
      t.string :shipping_city
      t.string :shipping_state
      t.string :shipping_zip

      t.timestamps
    end
  end
end
