class CreateBrandCards < ActiveRecord::Migration[6.0]
  def change
    create_table :brand_cards, id: :uuid do |t|
      t.references :user, type: :uuid, null: false, foreign_key: true
      t.string :name, null: false
      t.integer :number, null: false
      t.integer :status, null: false, default: :activated
      t.boolean :default, null: false, default: false

      t.timestamps
    end
  end
end
