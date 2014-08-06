class CreatePassports < ActiveRecord::Migration
  def change
    create_table :passports do |t|
      t.integer :user_id, default: 0
      t.string :provider_uid, limit: 20, default: ''
      t.string :provider_name,limit: 20, default: ''
      t.string :avatar_url,limit: 50, default: ''
      t.boolean :is_actived, default: false
      t.datetime :actived_at, default: '1900-01-01'

      t.timestamps
    end
  end
end
