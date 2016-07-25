class Bid < ActiveRecord::Base
  
  include ErrorsHelper
  
  belongs_to :favour
  belongs_to :user
  
  def validate
    if user_can_bid_on(favour)
      save
    else
      set_error('You can only bid on a favour posted to one of your clans that other users will benefit from - and only if no bid has already been accepted')
      false
    end
  end
  
  def validate_acceptance(current_user)
    if current_user_benefits_from(favour,current_user) 
      save
    else
      set_error('You can only accept a bid on a favour you benefit from')
      false
    end
  end
  
  private
  
  def user_can_bid_on(favour)
    favours_user_can_bid_on.include?(favour)
  end
  
  def favours_user_can_bid_on
    BiddableFilter.new(user).favours
  end
  
  def current_user_benefits_from(favour,current_user)
    current_user.favours_for_me.include?(favour)
  end
  
end
