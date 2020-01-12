class CreateContacts < ActiveRecord::Migration[6.0]
  def change
    create_table :contacts, id: :uuid do |t|
      t.references :person, type: :uuid, null: false, foreign_key: true
      t.integer :kind, null: false
      t.string :text, null: false
      t.string :complement

      t.timestamps
    end
  end
end
