class FavoursforothersDisplay
  
  attr_reader :user, :favourfilter
  
  def initialize(user, favourfilter = Favourfilter)
    @user = user
    @favourfilter = favourfilter.new(user)
  end
  
  def bidded_on
    favourfilter.bidded_on_by_user
  end
  
  def biddable
    favourfilter.biddable_on_by_user
  end
  
  def new_bid
    Bid.new
  end
  
end