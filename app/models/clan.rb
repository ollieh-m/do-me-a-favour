class Clan < ActiveRecord::Base
    
  has_many :user_clan_relationships
  has_many :users, through: :user_clan_relationships
  
  has_many :favour_clan_relationships
  has_many :favours, through: :favour_clan_relationships
  
  validates :name, presence: true, uniqueness: true
  
  def self.build_with(user:, params:)
    self.new(params).tap do |clan|
      clan.user_clan_relationships.build(user: user)
    end
  end
  
  def self.all_except(clans)
    self.all - clans
  end
    
end
