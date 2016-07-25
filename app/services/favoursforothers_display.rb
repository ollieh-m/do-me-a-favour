class FavoursforothersDisplay
  
  attr_reader :user, :biddable_filter, :bid
  
  def initialize(user, biddable_filter = BiddableFilter, bid = Bid)
    @user = user
    @biddable_filter = biddable_filter.new(user)
    @bid = bid
  end
  
  def bidded_on
    user.favours_bidded_on
  end
  
  def biddable
    biddable_filter.favours
  end
  
  def new_bid
    bid.new
  end
  
end