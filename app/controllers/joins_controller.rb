class JoinsController < ApplicationController
   
  def create
    join_clan
    redirect_to request.referer
  end
  
  def destroy
    leave_clan
    redirect_to request.referer
  end
  
  private
  
  def join_clan
    current_user.clans << clan
  end
  
  def leave_clan
    current_user.clans.delete(clan)
  end
  
  def clan
    Clan.find(params[:clan_id])
  end
   
end