class Favourfilter
  
  def initialize(user)
    @user = user
  end
  
  def favours_to_bid_on
    favours_array = extract_favours_from_clans
    favours_array = exclude_favours_with_accepted_bid(favours_array)
    favours_array = exclude_favours_not_benefiting_others(favours_array)
    exclude_favours_user_has_bidded_on(favours_array)
  end
  
  def favours_bidded_on
    @user.favours_bidded_on
  end
  
  private
  
  def extract_favours_from_clans
    favours_array = []
    @user.clans.each do |clan|
      favours_array += clan.favours
    end
    favours_array.uniq
  end
  
  def exclude_favours_with_accepted_bid(favours_array)
    favours_array.select{|favour| favour.bids.all?{|x| x.accepted.nil?} }
  end
  
  def exclude_favours_not_benefiting_others(favours_array)
    favours_array.select{|favour| (favour.users_benefiting - [@user]).length > 0}
  end
  
  def exclude_favours_user_has_bidded_on(favours_array)
    favours_array - favours_bidded_on
  end
  
end