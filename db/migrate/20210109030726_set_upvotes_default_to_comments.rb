class SetUpvotesDefaultToComments < ActiveRecord::Migration[6.1]
  def change
    change_column_default :comments, :upvotes, 1
  end
end
