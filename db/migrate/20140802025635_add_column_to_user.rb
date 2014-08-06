class AddColumnToUser < ActiveRecord::Migration
  def change
    add_column :users, :birthday, :date, default: '1900-01-01'
    add_column :users, :invite_token, :string, limit: 10, default: ''
    add_column :users, :province, :string, limit: 10, default: ''
    add_column :users, :city, :string,limit: 10, default: ''
    add_column :users, :phone, :string, limit: 15, default: ''
    add_column :users, :address, :string, limit: 100, default: ''
    add_column :users, :phone_verify, :boolean, default: false
    add_column :users, :email_verify, :boolean, default: false
  end
end
