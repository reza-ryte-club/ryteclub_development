class ChangeTextForTitle < ActiveRecord::Migration
  def change
    change_table :tales do |t|
      t.change :title, :text
    end  
  end
end
