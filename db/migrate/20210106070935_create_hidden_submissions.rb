class CreateHiddenSubmissions < ActiveRecord::Migration[6.1]
  def change
    create_table :hidden_submissions, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :submission, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
