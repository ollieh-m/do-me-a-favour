module BidsHelper
  
  def construct_bid_attributes
    params.require(:bid).permit(:amount).tap do |hash|
      hash[:favour_id]=params[:favour_id]
      hash[:user]=current_user
    end
  end
  
end