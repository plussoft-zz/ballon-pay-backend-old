class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses, id: :uuid do |t|
      t.references :person, type: :uuid, null: false, foreign_key: true
      t.integer :kind, null: false
      t.string :street, null: false
      t.string :number
      t.string :complement
      t.string :district
      t.string :city
      t.string :country
      t.string :zip_code

      t.timestamps
    end
  end
end
