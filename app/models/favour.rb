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
  
  def validate_completion(user)
    if users_benefiting.include?(user)
      save
    else
      set_error('You can only confirm completion of a favour if you benefit from the favour')
      false
    end
  end
  
end
