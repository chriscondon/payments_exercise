class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.references :loan, index: true, foreign_key: true
      t.decimal :amount, precision: 8, scale: 2
      t.datetime  :payment_date

      t.timestamps null: false
    end
  end
end
