class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users, id: :uuid do |t|
      t.string :uid
      t.string :email, null: false
      t.jsonb :auth_hash
    end

    add_index :users, :email, unique: true
  end
end
