class CreatePeople < ActiveRecord::Migration[6.0]
  def change
    create_table :people, id: :uuid do |t|
      t.references :user, type: :uuid, null: false, foreign_key: true
      t.string :full_name

      t.timestamps
    end
  end
end
