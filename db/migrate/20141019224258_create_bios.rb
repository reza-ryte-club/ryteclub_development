class CreateBios < ActiveRecord::Migration
  def change
    create_table :bios do |t|
      t.text :bio
      t.integer :user_id

      t.timestamps
    end
  end
end
