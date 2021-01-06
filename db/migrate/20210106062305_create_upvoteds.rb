class CreateUpvoteds < ActiveRecord::Migration[6.1]
  def change
    create_table :upvoteds, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.string :type
      t.uuid :item_id

      t.timestamps
    end
  end
end
