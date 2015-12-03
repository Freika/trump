class RemoveRealmAndAddRealmIdToCharacter < ActiveRecord::Migration
  def change
    remove_column :characters, :realm
    add_column :characters, :realm_id, :integer, null: false, default: 0
    add_index :characters, :realm_id
  end
end
