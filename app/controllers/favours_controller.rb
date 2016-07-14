class FavoursController < ApplicationController
  
  def formeindex
    @clans = current_user.clans
  end
  
  def forothersindex
    @favours = Favour.in_clans_of(user: current_user)
  end
  
  def create
    @favour = Favour.build_with(users_benefiting: [current_user], clans: params[:clan], params: favour_params)
    if @favour.validate_with(clans: params[:clan])
      redirect_to request.referer
    else
      flash.now[:errors] = @favour.errors
      @clans = current_user.clans
      render :formeindex
    end
  end
  
  private
  
  def favour_params
    params.permit(:description)
  end
  
end