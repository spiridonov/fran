class AddPriceRequest < ActiveRecord::Migration
  def change
    create_table :price_requests do |t|
      t.string :name
      t.string :phone
      t.boolean :closed, default: false, null: false
    end
  end
end
