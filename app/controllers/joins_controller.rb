class JoinsController < ApplicationController
   
  def create
    clan = Clan.find(params[:clan_id])
    current_user.clans << clan
    redirect_to request.referer
  end
  
  def destroy
    clan = Clan.find(params[:clan_id])
    current_user.clans.delete(clan)
    redirect_to request.referer
  end
   
end