class Favour < ActiveRecord::Base

  has_many :favour_clan_relationships
  has_many :clans, through: :favour_clan_relationships
  
  has_many :user_favour_relationships
  has_many :users_benefiting, through: :user_favour_relationships, source: :user
  
  has_many :bids
  
  def self.build_with(users_benefiting, clans, favour_params)
    Favour.new(favour_params).tap do |favour|
      favour.clans << clans
      favour.users_benefiting << users_benefiting
    end
  end
  
  def validate
    if(clans.empty? || description == '')
      set_error('You need to choose at least one clan') if clans.empty?
      set_error("Description can't be blank") if description == ''
      false
    else
      save
    end
  end
  
  def validate_completion_with(user:)
    if users_benefiting.include?(user)
      save
    else
      set_error('You can only confirm completion of a favour if you benefit from the favour')
      false
    end
  end
  
  def exchange_thankyou_points
    bid = bids.select{|x| x.accepted }.first
    add_points(bid)
    subtract_points(bid)
  end
  
  def forothersindex_status(user:)
    if self.bids.all?{|x| x.accepted.nil?}
      'Awaiting response to your bid'
    else
      accepted_or_rejected(user)
    end
  end
  
  def formeindex_status
    if bids.size > 0
      if completed == 'Confirmed'
        'This favour has been carried out'
      elsif bids.any?{|x| x.accepted == true}
        'A bid has been accepted for this favour'
      else 
        'Bids in waiting on your response'
      end
    end
  end
  
  private
  
  def accepted_or_rejected(user)
    if bids.select{|x| x.accepted == true}.first.user == user
      completed_or_awaiting_fulfilment
    else
      'Sorry, your bid was rejected'
    end
  end
  
  def completed_or_awaiting_fulfilment
    if completed == 'Confirmed'
      'Nice one - you did this favour'
    else
      'Your bid is accepted and awaiting fulfilment'
    end
  end
  
  def set_error(error_message)
    @errors.nil? ? @errors = [error_message] : @errors << error_message
  end
  
  def add_points(bid)
    bid.user.thankyoupoints += bid.amount
    bid.user.save
  end
  
  def subtract_points(bid)
    users_benefiting.each do |user|
      user.thankyoupoints -= (bid.amount / users_benefiting.length)
      user.save
    end
  end
  
end
