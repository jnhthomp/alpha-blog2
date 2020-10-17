class CreateArticleCategories < ActiveRecord::Migration[6.0]
  def change
    # Create article categories table for article-category association
    # Contains 2 columns one for article and one for category
    # Rows use these 2 id's for a relationship between article and category and vice versa
    create_table :article_categories do |t|
      # Add article_id of type int to article_categories table
      t.integer :article_id
      # Add category_id of type int to article_categories table
      t.integer :category_id
    end
  end
end
