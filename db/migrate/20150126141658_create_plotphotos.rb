class CreatePlotphotos < ActiveRecord::Migration
  def change
    create_table :plotphotos do |t|
      t.string :image
      t.integer :plot_id

      t.timestamps
    end
  end
end
