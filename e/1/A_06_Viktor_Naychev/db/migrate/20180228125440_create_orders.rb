class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.belongs_to :product, foreign_key: true
      t.date :date

      t.timestamps
    end
  end
end
