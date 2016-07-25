class AcceptsController < ApplicationController
  
  def create
    bid = accept_bid
    unless accept_bid.validate_acceptance(current_user)
      flash[:errors] = bid.errors
    end
    redirect_to request.referer
  end
  
  private
  
  def accept_bid
    Bid.find(params[:bid_id]).tap do |bid|
      bid.accepted = true
    end
  end
  
end