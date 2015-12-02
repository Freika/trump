class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.string :name, null: false, default: ''
      t.string :realm, null: false, default: ''
      t.integer :goods, default: 0

      t.timestamps null: false
    end
    add_index :characters, :goods
  end
end
