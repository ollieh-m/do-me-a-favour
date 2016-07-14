class CreateFavours < ActiveRecord::Migration
  def change
    create_table :favours do |t|
      t.string :description

      t.timestamps null: false
    end
  end
end
