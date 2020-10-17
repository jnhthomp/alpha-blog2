class AddTimestampsToArticles < ActiveRecord::Migration[6.0]
  def change
    # Update articles table with timestamps
    add_column :articles, :created_at, :datetime # initial creation timestamp
    add_column :articles, :updated_at, :datetime # article edit timestamp
  end
end
