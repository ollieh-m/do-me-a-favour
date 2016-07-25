class FavoursformeController < ApplicationController
  
  def show
    @favoursformedisplay = FavoursformeDisplay.new(current_user)
  end
  
end