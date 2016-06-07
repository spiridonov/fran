class AddTimestampsToPrices < ActiveRecord::Migration
  def change
    add_column :price_requests, :created_at, :datetime
    add_column :price_requests, :updated_at, :datetime
  end
end
