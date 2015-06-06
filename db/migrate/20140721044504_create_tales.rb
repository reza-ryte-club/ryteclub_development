class CreateTales < ActiveRecord::Migration
  def change
    create_table :tales do |t|
      t.string :title

      t.timestamps
    end
  end
end
