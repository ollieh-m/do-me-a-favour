class FavoursformeController < ApplicationController
  
  def show
    @clans = current_user.clans
    @users = User.all - [current_user]
    @favours_for_me = current_user.favours_for_me
  end
  
end