class CompletionsController < ApplicationController
  
  def create
    favour = Favour.find(params[:favour_id])
    favour.completed = 'Confirmed'
    if favour.validate_completion_with(user: current_user)
      favour.exchange_thankyou_points
    else
      flash[:errors] = favour.errors
    end
    redirect_to request.referer
  end
  
end