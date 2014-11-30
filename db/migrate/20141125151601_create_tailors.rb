class CreateTailors < ActiveRecord::Migration
  def change
    create_table :tailors do |t|
      t.integer :user_id
      t.string :desc
      t.string :desc_pic, limit: 50
      t.integer :book_counts, default: 0
      t.string :scope
      t.string :work_time
      t.string :experience, limit: 20

      t.timestamps
    end
  end
end
