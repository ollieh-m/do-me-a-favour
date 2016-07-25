class BidsController < ApplicationController
  
  include BidsHelper
  
  def create
    bid = Bid.new(construct_bid_attributes)
    unless bid.validate
      flash[:errors] = bid.errors
    end
    redirect_to request.referer
  end
  
end