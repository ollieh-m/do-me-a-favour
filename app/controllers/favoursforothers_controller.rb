class FavoursforothersController < ApplicationController
  
  def show
    @favoursforothersdisplay = FavoursforothersDisplay.new(current_user)
  end
  
end