class AddClanToUserClanRelationships < ActiveRecord::Migration
  def change
    add_reference :user_clan_relationships, :clan, index: true, foreign_key: true
  end
end
