class FavoursforothersController < ApplicationController
  
  def show
    @favoursforothers = FavoursforothersDisplay.new(current_user)
  end
  
end