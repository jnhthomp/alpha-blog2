class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    # Create categories table
    create_table :categories do |t|
      # Add name attribute of type string to categories table
      t.string :name
      # Add created_at and updated_at attributes to users table
      t.timestamps
    end
  end
end
