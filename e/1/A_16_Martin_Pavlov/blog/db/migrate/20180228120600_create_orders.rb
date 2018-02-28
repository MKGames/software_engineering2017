class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.text :text
      t.integer :id_user

      t.timestamps
    end
  end
end
