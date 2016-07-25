class BiddableFilter
  
  def initialize(user)
    @user = user
  end
  
  def favours
    favours_array = extract_favours_from_clans
    favours_array = exclude_favours_with_accepted_bid(favours_array)
    favours_array = exclude_favours_not_benefiting_others(favours_array)
    exclude_favours_user_has_bidded_on(favours_array)
  end
  
  private
  
  def extract_favours_from_clans
    Favour.where(id: favour_ids_from_user_clans)
  end
  
  def favour_ids_from_user_clans
    ids = []
    @user.clans.each do |clan|
      ids += clan.favours.map(&:id)
    end
    ids
  end
  
  def exclude_favours_with_accepted_bid(favours_array)
    favours_array.select{|favour| favour.bids.all?{|x| x.accepted.nil?} }
  end
  
  def exclude_favours_not_benefiting_others(favours_array)
    favours_array.select{|favour| (favour.users_benefiting - [@user]).length > 0}
  end
  
  def exclude_favours_user_has_bidded_on(favours_array)
    favours_array - @user.favours_bidded_on
  end
  
end