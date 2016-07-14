class DeleteUserFavourRelationshipTable < ActiveRecord::Migration
  def change
    drop_table(:user_favours_relationships)
  end
end
