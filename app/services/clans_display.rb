class ClansDisplay
  
  attr_reader :user
  
  def initialize(user)
    @user = user
  end
  
  def new_clan
    Clan.new
  end
  
  def my_clans
    @my_clans ||= user.clans
  end
  
  def other_clans
    Clan.all - my_clans
  end
  
end