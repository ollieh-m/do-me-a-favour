class CreateUserClanRelationships < ActiveRecord::Migration
  def change
    create_table :user_clan_relationships do |t|

      t.timestamps null: false
    end
  end
end
