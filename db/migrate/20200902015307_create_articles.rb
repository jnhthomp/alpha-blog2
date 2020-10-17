class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    # Create new articles table
    create_table :articles do |t|
      # Add title attributes of type string
      t.string :title
      # Add description attribute of type text (longer than string)
      t.text :description
    end
  end
end
