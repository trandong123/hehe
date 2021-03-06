class CreateCommentFoods < ActiveRecord::Migration[5.2]
  def change
    create_table :comment_foods do |t|
      t.string :content
      t.references :user, foreign_key: true
      t.references :food, foreign_key: true

      t.timestamps
    end
  end
end
