class Favoursforothers
  
  attr_reader :user, :favourfilter
  
  def initialize(user, favourfilter = Favourfilter)
    @user = user
    @favourfilter = favourfilter.new(user)
  end
  
  def bidded_on
    favourfilter.favours_bidded_on
  end
  
  def biddable
    favourfilter.favours_to_bid_on
  end
  
  def new_bid
    Bid.new
  end
  
end