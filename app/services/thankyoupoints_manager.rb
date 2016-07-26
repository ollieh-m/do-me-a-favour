class ThankyoupointsManager
  
  attr_reader :favour, :bid
  
  def initialize(favour)
    @favour = favour
    @bid = accepted_bid
  end
  
  def exchange_thankyou_points
    add_points
    subtract_points
  end
  
  private
  
  def accepted_bid
    favour.bids.select{|x| x.accepted }.first
  end
  
  def add_points
    user_who_bidded.thankyoupoints += bid.amount
    user_who_bidded.save
  end
  
  def subtract_points
    favour.users_benefiting.each do |user|
      user.thankyoupoints -= share_of_thankyoupoints_debt
      user.save
    end
  end
  
  def user_who_bidded
    @user ||= bid.user
  end
  
  def share_of_thankyoupoints_debt
    bid.amount / favour.users_benefiting.length
  end
  
end