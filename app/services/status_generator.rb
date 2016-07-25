class StatusGenerator
  
  attr_reader :user
  
  def initialize(user = :dummy)
    @user = user
  end
  
  def forothers_status(favour)
    if favour.bids.all?{|x| x.accepted.nil?}
      'Awaiting response to your bid'
    else
      accepted_or_rejected(favour)
    end
  end
  
  def forme_status(favour)
    if favour.bids.size > 0
      if favour.completed == 'Confirmed'
        'This favour has been carried out'
      elsif favour.bids.any?{|x| x.accepted == true}
        'A bid has been accepted for this favour'
      else 
        'Bids in waiting on your response'
      end
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