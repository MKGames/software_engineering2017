class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.text :description
      t.integer :userId

      t.timestamps
    end
  end
end
