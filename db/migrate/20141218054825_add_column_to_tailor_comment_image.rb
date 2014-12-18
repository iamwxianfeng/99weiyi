class AddColumnToTailorCommentImage < ActiveRecord::Migration
  def change
    add_column :tailor_comment_images, :image_id, :integer
    remove_column :tailor_comment_images, :image
  end
end
