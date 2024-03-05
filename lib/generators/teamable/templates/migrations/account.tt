# frozen_string_literal: true

class TeamableCreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.string :name, null: false
      t.boolean :personal_account, default: false
      t.timestamps
    end
  end
end
