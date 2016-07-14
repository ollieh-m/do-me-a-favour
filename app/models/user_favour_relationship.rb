class UserFavourRelationship < ActiveRecord::Base
  belongs_to :user
  belongs_to :favour
  validates_uniqueness_of :user, scope: :favour
end
