class CreateUserFavoursRelationships < ActiveRecord::Migration
  def change
    create_table :user_favours_relationships do |t|
      t.references :user, index: true, foreign_key: true
      t.references :favour, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
