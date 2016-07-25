class FavoursforothersDisplay
  
  attr_reader :user, :biddable_filter, :bid, :status_generator
  
  def initialize(user, biddable_filter = BiddableFilter, bid = Bid, status_generator = StatusGenerator)
    @user = user
    @biddable_filter = biddable_filter.new(user)
    @status_generator = status_generator.new(user)
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
  
  def status(favour)
    status_generator.forotherspage_favour_status(favour)
  end
  
end