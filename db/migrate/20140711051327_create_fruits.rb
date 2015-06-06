class CreateFruits < ActiveRecord::Migration
  def change
    create_table :fruits do |t|
      t.string :pulp

      t.timestamps
    end
  end
end
