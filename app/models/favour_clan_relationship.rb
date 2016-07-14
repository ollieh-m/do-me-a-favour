class FavourClanRelationship < ActiveRecord::Base
  belongs_to :favour
  belongs_to :clan
  validates_uniqueness_of :favour, scope: :clan
end
