class Clan < ActiveRecord::Base
    
  has_many :user_clan_relationships
  has_many :users, through: :user_clan_relationships
  
  has_many :favour_clan_relationships
  has_many :favours, through: :favour_clan_relationships
  
  validates :name, presence: true, uniqueness: true
  
  def self.build_with(current_user, clan_params)
    self.new(clan_params).tap do |clan|
      clan.users << current_user
    end
  end
    
end
