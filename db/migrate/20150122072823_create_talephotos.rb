class CreateTalephotos < ActiveRecord::Migration
  def change
    create_table :talephotos do |t|
      t.string :cover
      t.integer :tale_id

      t.timestamps
    end
  end
end
