class AddAdminToUsers < ActiveRecord::Migration[6.0]
  def change
    # Adds admin role to some users
    # By default users will not be admin, must be changed on backends
    add_column :users, :admin, :boolean, default: false
  end
end
