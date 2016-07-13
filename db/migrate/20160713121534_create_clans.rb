class CreateClans < ActiveRecord::Migration
  def change
    create_table :clans do |t|
      t.string :name, index: true
      t.string :description

      t.timestamps null: false
    end
  end
end
