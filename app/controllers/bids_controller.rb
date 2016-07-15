class BidsController < ApplicationController
  
  def create
    bid = Bid.new(bid_params)
    if bid.save
      redirect_to request.referer
    end
  end
  
  private
  
  def bid_params
    params.require(:bid).permit(:amount).tap do |hash|
      hash[:favour_id]=params[:favour_id]
      hash[:user]=current_user
    end
  end
  
end