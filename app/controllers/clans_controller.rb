class ClansController < ApplicationController
    
  def index
    @clan = Clan.new
    @clans = Clan.all
    @myclans = current_user.clans
  end
  
  def create
    @clan = Clan.build_with(user: current_user, params: clan_params)
    if @clan.save
      redirect_to request.referer
    else
      flash[:errors] = @clan.errors.full_messages
      render :index
    end
  end
  
  private
  
  def clan_params
    params.require(:clan).permit(:name,:description)
  end
  
end