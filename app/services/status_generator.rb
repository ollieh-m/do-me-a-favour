class StatusGenerator
  
  attr_reader :favour, :user
  
  def initialize(favour,user)
    @favour = favour
    @user = user
  end
  
  def forothers_status
    if favour.bids.all?{|x| x.accepted.nil?}
      'Awaiting response to your bid'
    else
      accepted_or_rejected
    end
  end
  
  private
  
  def accepted_or_rejected
    if favour.bids.select{|x| x.accepted == true}.first.user == user
      completed_or_awaiting_fulfilment
    else
      'Sorry, your bid was rejected'
    end
  end
  
  def completed_or_awaiting_fulfilment
    if favour.completed == 'Confirmed'
      'Nice one - you did this favour'
    else
      'Your bid is accepted and awaiting fulfilment'
    end
  end
  
end