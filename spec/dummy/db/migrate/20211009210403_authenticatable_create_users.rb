# frozen_string_literal: true

class AuthenticatableCreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      ## Authenticatable
      t.string :email, null: false, default: ""
      t.string :password_digest, null: false, default: ""
      t.string :reset_password_token, null: false, default: ""
      t.datetime :reset_password_sent_at
      t.timestamps null: false
    end
    add_index :users, :email, unique: true
    add_index :users, :reset_password_token
  end
end
