class CreateAccountTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :account_types, id: :uuid do |t|
      t.references :user, type: :uuid, null: false, foreign_key: true
      t.string :name, null: false
      t.integer :kind, null: false
      t.boolean :default, null: false, default: false

      t.timestamps
    end
  end
end
