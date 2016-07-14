class UserClanRelationship < ActiveRecord::Base
  belongs_to :user
  belongs_to :clan
  validates_uniqueness_of :user, scope: :clan
end
