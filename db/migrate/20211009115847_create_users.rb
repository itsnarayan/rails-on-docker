class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.references :company, foreign_key: { on_delete: :cascade }, null: true
      t.string :email, null: false, unique: true
      t.string :first_name
      t.string :last_name
      t.datetime :confirmed_at
      t.boolean :agreement_required

      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end
