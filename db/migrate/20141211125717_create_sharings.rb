class CreateSharings < ActiveRecord::Migration
  def change
    create_table :sharings do |t|
      t.string :email
      t.integer :tale_id

      t.timestamps
    end
  end
end
