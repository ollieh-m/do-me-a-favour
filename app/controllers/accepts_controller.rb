class AcceptsController < ApplicationController
  
  def create
    bid = Bid.find(params[:bid_id])
    bid.accepted = true
    unless bid.validate_acceptance_with(user: current_user)
      flash[:errors] = bid.errors
    end
    redirect_to request.referer
  end
  
end