class CreateBorrows < ActiveRecord::Migration[7.1]
  def change
    create_table :borrows do |t|
      t.references :book, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.datetime :end_date
      t.boolean :returned, default: false
      t.boolean :expired, default: false

      t.timestamps
    end
  end
end
