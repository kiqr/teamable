# frozen_string_literal: true

class TeamableCreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.string :name, null: false
      t.string :billing_email, null: false
      t.timestamps
    end
  end
end