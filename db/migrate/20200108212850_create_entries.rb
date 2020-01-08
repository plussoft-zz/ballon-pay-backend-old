class CreateEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :entries, id: :uuid do |t|
      t.references :account, type: :uuid, null: false, foreign_key: true
      t.datetime :due_date, null: false
      t.integer :number
      t.string :description
      t.decimal :amount, precision: 15, scale: 3, null: false
      t.integer :kind, null: false

      t.timestamps
    end
  end
end
