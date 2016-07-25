class CompletionsController < ApplicationController
  
  def create
    favour = complete_favour
    if favour.validate_completion(current_user)
      favour.exchange_thankyou_points
    else
      flash[:errors] = favour.errors
    end
    redirect_to request.referer
  end
  
  private
  
  def complete_favour
    Favour.find(params[:favour_id]).tap do |favour|
      favour.completed = 'Confirmed'
    end
  end
  
end