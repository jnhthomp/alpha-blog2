class AddUserIdToArticles < ActiveRecord::Migration[6.0]
  def change
    # Update articles table to associate with users
    # adds user_id attribute to articles table
    add_column :articles, :user_id, :int
  end
end
