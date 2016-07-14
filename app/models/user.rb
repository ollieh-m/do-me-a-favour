class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
  
  has_many :user_clan_relationships, dependent: :destroy
  has_many :clans, through: :user_clan_relationships
  
  has_many :user_favour_relationships
  has_many :favours_for_me, through: :user_favour_relationships, source: :favour
end
