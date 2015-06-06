class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|


   		t.string :from_email
   		t.string :to_email
   		t.integer :tale_id
   		t.text :message
	    t.timestamps

    end
  end
end
