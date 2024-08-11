# frozen_string_literal: true

class AddUniquesToBook < ActiveRecord::Migration[7.1]
  def change
    add_index :books, :isbn, unique: true
  end
end
