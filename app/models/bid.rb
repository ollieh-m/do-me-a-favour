class Bid < ActiveRecord::Base
  
  include ErrorsHelper
  
  belongs_to :favour
  belongs_to :user
  
  def validate
    if favours_user_can_bid_on.include?(favour) 
      save
    else
      set_error('You can only bid on a favour posted to one of your clans that other users will benefit from - and only if no bid has already been accepted')
      false
    end
  end
  
  def validate_acceptance_with(user:)
    if favours_benefiting(user).include?(favour)
      save
    else
      set_error('You can only accept a bid on a favour you benefit from')
      false
    end
  end
  
  private
  
  def favours_user_can_bid_on
    Favourfilter.new(user).biddable_on_by_user
  end
  
  def favours_benefiting(user)
    Favourfilter.new(user).benefiting_user
  end
  
end
