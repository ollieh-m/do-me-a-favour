class Favour < ActiveRecord::Base
  
  include ErrorsHelper

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
