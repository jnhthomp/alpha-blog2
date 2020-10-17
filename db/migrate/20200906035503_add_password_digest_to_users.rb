class AddPasswordDigestToUsers < ActiveRecord::Migration[6.0]
  def change
    # Secure user passwords with bcrypt
    # Bcrypt looks for a attribute password_digest to work
    add_column :users, :password_digest, :string
  end
end
