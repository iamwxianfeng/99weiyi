class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :user_id
      t.string :url
      t.integer :up_size_id
      t.integer :down_size_id
      t.text :content

      t.timestamps
    end
  end
end
