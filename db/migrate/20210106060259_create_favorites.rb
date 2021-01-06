class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.string :type
      t.uuid :item_id

      t.timestamps
    end
  end
end
