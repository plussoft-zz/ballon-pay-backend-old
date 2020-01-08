class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts, id: :uuid do |t|
      t.references :store, type: :uuid, null: false, foreign_key: true
      t.references :account_type, type: :uuid, null: false, foreign_key: true
      t.integer :number, null: false

      t.timestamps
    end
    add_index :accounts, [:store_id, :number], :unique => true
  end
end
