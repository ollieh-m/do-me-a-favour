class Favourfilter
  
  def initialize(user)
    @user = user
  end
  
  def biddable_on_by_user
    favours_array = extract_favours_from_clans
    favours_array = exclude_favours_with_accepted_bid(favours_array)
    favours_array = exclude_favours_not_benefiting_others(favours_array)
    exclude_favours_user_has_bidded_on(favours_array)
  end
  
  def bidded_on_by_user
    @user.favours_bidded_on
  end
  
  def benefiting_user
    @user.favours_for_me
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
    favours_array - bidded_on_by_user
  end
  
end