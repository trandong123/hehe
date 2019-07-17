class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.integer :usertype, default: 1
      t.string :username
      t.string :address
      t.string :phone_number
      t.string :password_digest
      t.string :remember_digest
      t.string :activation_digest
      t.boolean :activated, default: true
      t.datetime :activated_at

      t.timestamps
    end
  end
end
