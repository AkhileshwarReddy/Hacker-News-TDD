class AddShownhnAskhnIsflaggedToSubmissions < ActiveRecord::Migration[6.1]
  def change
    add_column :submissions, :is_showhn, :boolean, default: false
    add_column :submissions, :is_askhn, :boolean, default: false
    add_column :submissions, :is_flagged, :boolean, default: false
  end
end
