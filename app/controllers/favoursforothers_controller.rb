class FavoursforothersController < ApplicationController
  
  def show
    @favoursforothers = Favoursforothers.new(current_user)
  end
  
end