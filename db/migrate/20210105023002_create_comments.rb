class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments, id: :uuid do |t|
      t.uuid :parent_comment_id
      t.text :content
      t.integer :upvotes
      t.boolean :is_flagged, default: false
      t.string :level, default: "0"
      
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :submission, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
