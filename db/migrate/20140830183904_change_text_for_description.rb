class ChangeTextForDescription < ActiveRecord::Migration
  def change


    change_table :plots do |t|
      t.change :description, :text
    end  

  end
end
