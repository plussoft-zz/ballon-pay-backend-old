class CreatePeople < ActiveRecord::Migration[6.0]
  def change
    create_table :people, id: :uuid do |t|
      t.references :user, type: :uuid, null: false, foreign_key: true
      t.string :full_name, null: false
      t.string :document_number, null: false

      t.timestamps
    end
    add_index :people, [:user_id, :document_number], :unique => true
  end
end
