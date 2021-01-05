class CreateSubmissions < ActiveRecord::Migration[6.1]
  def change
    create_table :submissions, id: :uuid do |t|
      t.string :title
      t.string :url
      t.text :text
      t.integer :upvotes, :default => 1
      t.references :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
