class JoinsController < ApplicationController
   
  def create
    clan = Clan.find(params[:clan_id])
    clan.user_clan_relationships.create(user: current_user)
    redirect_to request.referer
  end
  
  def destroy
    clan = Clan.find(params[:clan_id])
    clan.user_clan_relationships.destroy_where(user: current_user)
    redirect_to request.referer
  end
   
end