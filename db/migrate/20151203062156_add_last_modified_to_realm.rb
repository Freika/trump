class AddLastModifiedToRealm < ActiveRecord::Migration
  def change
    add_column :realms, :last_modified, :string, null: false, default: ''
  end
end
