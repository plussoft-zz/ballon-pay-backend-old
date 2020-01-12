class CreateStores < ActiveRecord::Migration[6.0]
  def change
    create_table :stores, id: :uuid do |t|
      t.references :user, type: :uuid, null: false, foreign_key: true
      t.integer :number, null: false
      t.string :name, null: false
      t.boolean :default, null: false, default: false

      t.timestamps
    end
    add_index :stores, [:user_id, :number], :unique => true
  end
end
