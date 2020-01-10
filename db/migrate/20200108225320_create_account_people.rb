class CreateAccountPeople < ActiveRecord::Migration[6.0]
  def change
    create_table :account_people, id: :uuid do |t|
      t.references :account, type: :uuid, null: false, foreign_key: true
      t.references :person, type: :uuid, null: false, foreign_key: true
      t.integer :kind, null: false

      t.timestamps
    end
  end
end
