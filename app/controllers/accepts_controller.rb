class AcceptsController < ApplicationController
  
  def create
    bid = Bid.find(params[:bid_id])
    bid.update(accepted: true)
    redirect_to request.referer
  end
  
end