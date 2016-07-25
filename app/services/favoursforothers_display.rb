class FavoursforothersDisplay
  
  attr_reader :user, :biddable_filter
  
  def initialize(user, biddable_filter = BiddableFilter)
    @user = user
    @biddable_filter = biddable_filter.new(user)
  end
  
  def bidded_on
    user.favours_bidded_on
  end
  
  def biddable
    biddable_filter.favours
  end
  
  def new_bid
    Bid.new
  end
  
end