class StatusGenerator
  
  attr_reader :favour, :user
  
  def initialize(user)
    @user = user
  end
  
  def forothers_status(favour)
    if favour.bids.all?{|x| x.accepted.nil?}
      'Awaiting response to your bid'
    else
      accepted_or_rejected(favour)
    end
  end
  
  private
  
  def accepted_or_rejected(favour)
    if favour.bids.select{|x| x.accepted == true}.first.user == user
      completed_or_awaiting_fulfilment(favour)
    else
      'Sorry, your bid was rejected'
    end
  end
  
  def completed_or_awaiting_fulfilment(favour)
    if favour.completed == 'Confirmed'
      'Nice one - you did this favour'
    else
      'Your bid is accepted and awaiting fulfilment'
    end
  end
  
end