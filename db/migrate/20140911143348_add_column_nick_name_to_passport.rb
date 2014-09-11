class AddColumnNickNameToPassport < ActiveRecord::Migration
  def change
    add_column :passports, :nick_name, :string, limit: 100
  end
end
