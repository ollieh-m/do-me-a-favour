class HomeController < ApplicationController
  
  before_filter :check_if_user_is_signed_in, only: [:signed_out]
    
  def signout_out
  end
  
  def signed_in
  end
  
  private
  
  def check_if_user_is_signed_in
    if signed_in?
      redirect_to '/dashboard'
    end
  end

end