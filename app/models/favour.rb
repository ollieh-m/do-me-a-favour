class Favour < ActiveRecord::Base

  has_many :favour_clan_relationships
  has_many :clans, through: :favour_clan_relationships
  
  has_many :user_favour_relationships
  has_many :users_benefiting, through: :user_favour_relationships, source: :user
  
  has_many :bids
  
  validates :description, presence: true
  
  def self.build_with(users_benefiting:,clans:,params:)
    Favour.new(params).tap do |favour|
      initialize_favour_clan_relationships(favour,clans)
      initialize_favour_user_relationships(favour,users_benefiting)
    end
  end
  
  def validate_with(clans:)
    if(clans.nil? || self.description == '')
      set_error('You need to choose at least one clan') if clans.nil?
      set_error("Description can't be blank") if description == ''
      false
    else
      save
    end
  end
  
  def forothersindex_status(user:)
    if self.bids.all?{|x| x.accepted.nil?}
      'Awaiting response to your bid'
    else
      accepted_or_rejected(user)
    end
  end
  
  def formeindex_status
    if bids.size > 0
      return 'Bids in waiting on your response' if self.bids.all?{|x| x.accepted.nil?}
      return 'A bid has been accepted for this favour' if self.bids.any?{|x| x.accepted == true}
    end
  end
  
  private
  
  def accepted_or_rejected(user)
    if bids.select{|x| x.accepted == true}.first.user == user
      'Your bid is accepted and awaiting fulfilment'
    else
      'Sorry, your bid was rejected'
    end
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
