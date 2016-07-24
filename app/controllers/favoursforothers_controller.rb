class FavoursforothersController < ApplicationController
  
  def show
    @bidded_on_favours = current_user.favours_bidded_on
    @bid_on_favours = current_user.favours_to_bid_on
    @bid = Bid.new
  end
  
end