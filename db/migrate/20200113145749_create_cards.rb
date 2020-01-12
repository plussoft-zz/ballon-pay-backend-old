class CreateCards < ActiveRecord::Migration[6.0]
  def change
    create_table :cards, id: :uuid do |t|
      t.references :account_person, type: :uuid, null: false, foreign_key: true
      t.references :brand_card, type: :uuid, null: false, foreign_key: true
      t.string :printed_name, null: false
      t.date :due_date, null: false
      t.integer :verification_code, null: false
      t.integer :number, null: false
      t.string :full_number, null: false

      t.timestamps
    end
  end
end
