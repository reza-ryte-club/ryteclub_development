class CreateFollowers < ActiveRecord::Migration
  def change
    create_table :followers do |t|
      t.integer :users_id
      t.integer :followings_id

      t.timestamps
    end
  end
end
