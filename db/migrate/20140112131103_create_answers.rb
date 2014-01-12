class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :user_id
      t.integer :question_id
      t.text :content
      t.references :question

      t.timestamps
    end
    add_index :answers, :question_id
  end
end
