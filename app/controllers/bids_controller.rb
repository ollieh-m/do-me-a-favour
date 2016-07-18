class BidsController < ApplicationController
  
  def create
    bid = Bid.new(bid_params)
    unless bid.validate
      flash[:errors] = bid.errors
    end
    redirect_to request.referer
  end
  
  private
  
  def bid_params
    params.require(:bid).permit(:amount).tap do |hash|
      hash[:favour_id]=params[:favour_id]
      hash[:user]=current_user
    end
  end
  
end