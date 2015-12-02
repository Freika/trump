class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :wow_id, null: false
      t.string :name, default: ''

      t.timestamps null: false
    end
    add_index :items, :wow_id
  end
end
