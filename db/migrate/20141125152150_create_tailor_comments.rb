class CreateTailorComments < ActiveRecord::Migration
  def change
    create_table :tailor_comments do |t|
      t.integer :commenter_id
      t.text :content
      t.integer :rating
      t.references :tailor

      t.timestamps
    end
    add_index :tailor_comments, :tailor_id
  end
end
