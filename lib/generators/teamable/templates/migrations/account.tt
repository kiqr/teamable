# frozen_string_literal: true

class TeamableCreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.string :name, null: false
      t.string :public_uid, null: false
      t.boolean :personal_account, default: false
      t.timestamps
    end

    add_index :accounts, :public_uid, unique: true
  end
end
