class AddColomnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :phone_no, :string
    add_column :users, :photo, :binary
    add_column :users, :address, :text
    add_column :users, :photo_file_name, :string
    add_column :users, :photo_content_type, :string
    add_column :users, :photo_file_size, :integer
    add_column :users, :photo_updated_at, :datetime
  end
end
