class CreatePlots < ActiveRecord::Migration
  def change
    create_table :plots do |t|
      t.integer :tales_id
      t.string :description
      t.integer :users_id
      t.timestamps
    end
  end
end
