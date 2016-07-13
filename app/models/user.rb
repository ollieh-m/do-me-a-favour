class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
  
  has_many :user_clan_relationships, dependent: :destroy
  has_many :clans, through: :user_clan_relationships
end
