class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.references :favour, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.boolean :accepted
      t.integer :amount

      t.timestamps null: false
    end
  end
end
