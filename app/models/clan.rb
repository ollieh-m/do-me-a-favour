class Clan < ActiveRecord::Base
    
  has_many :user_clan_relationships do
    def destroy_where(user:)
      self.find_by(user: user).destroy
    end
  end
  has_many :users, through: :user_clan_relationships
  validates :name, presence: true, uniqueness: true
  
  def self.build_with(user:, params:)
    self.new(params).tap do |clan|
      clan.user_clan_relationships.build(user: user)
    end
  end
  
  def self.all_except_where(user:)
    clan_ids = UserClanRelationship.where(user: user).map(&:clan_id)
    self.where.not(id: clan_ids)
  end
    
end
