class FavourClanRelationship < ActiveRecord::Base
  belongs_to :favour
  belongs_to :clan
end
