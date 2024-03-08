# frozen_string_literal: true

class TeamableAddPersonalAccountToUsers < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :personal_account, foreign_key: { to_table: :accounts }, null: true
  end
end
