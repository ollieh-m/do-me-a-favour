class FavoursController < ApplicationController
  
  def create
    @favour = Favour.build_with(users_benefiting: users_benefiting, clans: params[:clan], params: favour_params)
    if @favour.validate_with(clans: params[:clan])
      redirect_to request.referer
    else
      flash[:errors] = @favour.errors
      redirect_to favoursforme_path
    end
  end
  
  private
  
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