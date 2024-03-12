# frozen_string_literal: true

class TeamableCreateMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :members do |t|
      t.references :user, foreign_key: {to_table: :users}
      t.references :account, foreign_key: {to_table: :accounts}
      t.string :role, nullable: false
      t.timestamps
    end
  end
end
