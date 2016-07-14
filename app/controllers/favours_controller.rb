class FavoursController < ApplicationController
  
  def formeindex
    @clans = current_user.clans
  end
  
  def forothersindex
    @favours = Favour.all_in_clans_of(user: current_user)
  end
  
  def create
    favour = Favour.build_with(clans: params[:clan], params: favour_params)
    if favour.save
      redirect_to request.referer
    end
  end
  
  private
  
  def favour_params
    params.permit(:description)
  end
  
end