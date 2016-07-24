class FavoursController < ApplicationController
  
  include FavoursHelper
  
  def create
    favour = Favour.build_with(users_benefiting, clans, favour_params)
    unless favour.validate
      flash[:errors] = favour.errors
    end
    redirect_to request.referer
  end
  
  private
  
  def clans
    generate_clans_array(params[:clan])
  end
  
  def users_benefiting
    generate_users_array(current_user,params[:users_benefiting])
  end
  
  def favour_params
    params.permit(:description)
  end
  
end