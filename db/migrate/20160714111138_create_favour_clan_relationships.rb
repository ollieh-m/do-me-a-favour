class CreateFavourClanRelationships < ActiveRecord::Migration
  def change
    create_table :favour_clan_relationships do |t|
      t.references :favour, index: true, foreign_key: true
      t.references :clan, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
