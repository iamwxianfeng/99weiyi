class CreateTailorCommentImages < ActiveRecord::Migration
  def change
    create_table :tailor_comment_images do |t|
      t.string :image
      t.references :tailor_comment

      t.timestamps
    end
    add_index :tailor_comment_images, :tailor_comment_id
  end
end
