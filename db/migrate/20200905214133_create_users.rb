class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    # Create users table
    create_table :users do |t|
      # Add username attribute of type string to users table
      t.string :username
      # Add email attribute of type string to users table
      t.string :email
      # Add created_at and updated_at datetime attributes to users table
      t.timestamps
    end
  end
end
