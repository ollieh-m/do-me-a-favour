class HomeController < ApplicationController
  
  before_filter :check_if_user_is_signed_in
    
  def show
  end
  
  private
  
  def check_if_user_is_signed_in
    if signed_in?
      redirect_to dashboard_path
    end
  end

end