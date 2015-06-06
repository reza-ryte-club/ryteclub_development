class CreateJournals < ActiveRecord::Migration
  def change
    create_table :journals do |t|
      t.string :notification_type
      t.integer :notification_id
      t.integer :notification_to

      t.timestamps
    end
  end
end
