class Favour < ActiveRecord::Base
    
  has_many :favour_clan_relationships
  has_many :clans, through: :favour_clan_relationships
  
  def self.build_with(clans:,params:)
    Favour.new(params).tap do |favour|
      clans.each_key do |clan|
        favour.favour_clan_relationships.build(clan_id: clan.to_i)
      end
    end
  end
  
  def self.all_in_clans_of(user:)
    favours = []
    user.clans.each do |clan|
      favours += clan.favours
    end
    favours.uniq
  end
  
end
