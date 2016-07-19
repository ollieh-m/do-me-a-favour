class Bid < ActiveRecord::Base
  belongs_to :favour
  belongs_to :user
  
  def validate
    if user.favours_to_bid_on.include?(favour)
      save
    else
      @errors = ['You can only bid on a favour posted to one of your clans that other users will benefit from - and only if no bid has already been accepted']
      false
    end
  end
  
  def validate_acceptance_with(user:)
    if user.favours_for_me.include?(favour)
      save
    else
      @errors = ['You can only accept a bid on a favour you benefit from']
      false
    end
  end
end
