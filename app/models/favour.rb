class Favour < ActiveRecord::Base
  
  attr_reader :customerrors

  has_many :favour_clan_relationships
  has_many :clans, through: :favour_clan_relationships
  
  has_many :user_favour_relationships
  has_many :users_benefiting, through: :user_favour_relationships, source: :user
  
  validates :description, presence: true
  
  def self.build_with(users_benefiting:,clans:,params:)
    Favour.new(params).tap do |favour|
      initialize_favour_clan_relationships(favour,clans)
      initialize_favour_user_relationships(favour,users_benefiting)
    end
  end
  
  def self.in_clans_of(user:)
    favours = extract_favours_from_clans_of(user)
    exclude_favours_only_benefiting(user,favours)
  end
  
  def validate_given(clans:)
    if(clans.nil? || self.description == '')
      set_error('You need to choose at least one clan') if clans.nil?
      set_error("Description can't be blank") if description == ''
      false
    else
      save
    end
  end
  
  private
  
  def self.extract_favours_from_clans_of(user)
    favours = []
    user.clans.each do |clan|
      favours += clan.favours
    end
    favours.uniq
  end
  
  def self.exclude_favours_only_benefiting(user,favours)
    favours.select{|favour| (favour.users_benefiting - [user]).length > 0}
  end
  
  def set_error(error_message)
    @errors.nil? ? @errors = [error_message] : @errors << error_message
  end
  
  def self.initialize_favour_clan_relationships(favour,clans)
    unless clans.nil?
      clans.each_key do |clan|
        favour.favour_clan_relationships.build(clan_id: clan.to_i)
      end
    end
  end
  
  def self.initialize_favour_user_relationships(favour,users_benefiting)
    unless users_benefiting.nil?
      users_benefiting.each do |user|
        favour.user_favour_relationships.build(user: user)
      end
    end
  end
  
end
