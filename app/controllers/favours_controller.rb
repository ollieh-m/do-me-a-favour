class FavoursController < ApplicationController
  
  def formeindex
    set_display_attributes
  end
  
  def forothersindex
    @bidded_on_favours = current_user.favours_bidded_on
    @bid_on_favours = Favour.in_clans_of(user: current_user) - @bidded_on_favours
    @bid = Bid.new
  end
  
  def create
    @favour = Favour.build_with(users_benefiting: users_benefiting, clans: params[:clan], params: favour_params)
    if @favour.validate_with(clans: params[:clan])
      redirect_to request.referer
    else
      flash.now[:errors] = @favour.errors
      set_display_attributes
      render :formeindex
    end
  end
  
  private
  
  def set_display_attributes
    @clans = current_user.clans
    @users = User.all - [current_user]
  end
  
  def users_benefiting
    array = [current_user]
    unless params[:users_benefiting].nil?
      params[:users_benefiting].each{|user_id| array << User.find(user_id.to_i)}
    end
    array
  end
  
  def favour_params
    params.permit(:description)
  end
  
end