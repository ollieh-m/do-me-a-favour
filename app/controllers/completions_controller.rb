class CompletionsController < ApplicationController
  
  def create
    favour = Favour.find(params[:favour_id])
    favour.completed = 'Confirmed'
    favour.save
    redirect_to request.referer
  end
  
end