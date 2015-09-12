class AddReferralToUsers < ActiveRecord::Migration
  def up
    add_column :users, :referral_code, :string

    add_index :users, [:referral_code]

    User.all.each do |user|
      user.ensure_referral_code
      user.save
    end
  end

  def down
    remove_index :users, [:referral_code]
    remove_column :users, :referral_code
  end
end
