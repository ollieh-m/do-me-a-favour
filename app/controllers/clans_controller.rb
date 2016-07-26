class ClansController < ApplicationController
    
  def index
    @clansdisplay = ClansDisplay.new(current_user)
  end
  
  def create
    clan = Clan.build_with(user: current_user, params: clan_params)
    unless clan.save
      flash[:errors] = clan.errors.full_messages
    end
    redirect_to request.referer
  end
  
  private
  
  def clan_params
    params.require(:clan).permit(:name,:description)
  end
  
end