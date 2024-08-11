# frozen_string_literal: true

class ChangeBorrow < ActiveRecord::Migration[7.1]
  def change
    add_column :borrows, :status, :integer

    remove_column :borrows, :returned
    remove_column :borrows, :expired
  end
end
