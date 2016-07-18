class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
  
  has_many :user_clan_relationships, dependent: :destroy
  has_many :clans, through: :user_clan_relationships
  
  has_many :bids
  has_many :favours_bidded_on, through: :bids, source: :favour
  
  has_many :user_favour_relationships
  has_many :favours_for_me, through: :user_favour_relationships, source: :favour
  
  def favours_to_bid_on
    favours_array = extract_favours_from_clans
    favours_array = exclude_favours_with_accepted_bid(favours_array)
    favours_array = exclude_favours_not_benefiting_others(favours_array)
    exclude_favours_user_has_bidded_on(favours_array)
  end
  
  private
  
  def extract_favours_from_clans
    favours_array = []
    clans.each do |clan|
      favours_array += clan.favours
    end
    favours_array.uniq
  end
  
  def exclude_favours_with_accepted_bid(favours_array)
    favours_array.select{|favour| favour.bids.all?{|x| x.accepted.nil?} }
  end
  
  def exclude_favours_not_benefiting_others(favours_array)
    favours_array.select{|favour| (favour.users_benefiting - [self]).length > 0}
  end
  
  def exclude_favours_user_has_bidded_on(favours_array)
    favours_array - favours_bidded_on
  end

end
