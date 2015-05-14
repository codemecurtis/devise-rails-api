class AddAccessTokenToClient < ActiveRecord::Migration
  def change
    add_column :clients, :access_token, :string
    add_column :clients, :username, :string
  end
end
