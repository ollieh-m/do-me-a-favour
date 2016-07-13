class AddUserToUserClanRelationships < ActiveRecord::Migration
  def change
    add_reference :user_clan_relationships, :user, index: true, foreign_key: true
  end
end
