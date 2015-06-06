class AddTrendingFactorToTales < ActiveRecord::Migration
  def change
  	add_column :tales, :trending_factor, :integer
  end
end
