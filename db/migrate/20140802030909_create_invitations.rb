class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.integer :user_id, default: 0
      t.string :item_type, limit: 10, default: ''
      t.string :value, limit:20, default: ''
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
