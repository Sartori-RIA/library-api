# frozen_string_literal: true

class CreateAllowlistedJwts < ActiveRecord::Migration[7.1]
  def change
    create_table :allowlisted_jwts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :jti
      t.string :aud
      t.datetime :exp

      t.timestamps
    end
  end
end
