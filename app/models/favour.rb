class Favour < ActiveRecord::Base
  
  attr_reader :customerrors

  has_many :favour_clan_relationships
  has_many :clans, through: :favour_clan_relationships
  
  validates :description, presence: true
  
  def self.build_with(clans:,params:)
    Favour.new(params).tap do |favour|
      unless clans.nil?
        clans.each_key do |clan|
          favour.favour_clan_relationships.build(clan_id: clan.to_i)
        end
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
  
  def set_error(error_message)
    @errors.nil? ? @errors = [error_message] : @errors << error_message
  end
  
end
