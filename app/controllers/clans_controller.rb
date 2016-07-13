class ClansController < ApplicationController
    
  def index
    @clan = Clan.new
    set_display_clans
  end
  
  def create
    @clan = Clan.build_with(user: current_user, params: clan_params)
    if @clan.save
      redirect_to request.referer
    else
      flash.now[:errors] = @clan.errors.full_messages
      set_display_clans
      render :index
    end
  end
  
  private
  
  def clan_params
    params.require(:clan).permit(:name,:description)
  end
  
  def set_display_clans
    @myclans = current_user.clans
    @otherclans = Clan.all_except(@myclans)
  end
  
end