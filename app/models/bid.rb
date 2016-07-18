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
end
