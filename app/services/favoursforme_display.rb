class FavoursformeDisplay
  
  attr_reader :user, :status_generator
  
  def initialize(user, status_generator = StatusGenerator)
    @user = user
    @status_generator = status_generator.new
  end
  
  def clans
    user.clans
  end
  
  def users
    User.all - [user]
  end
  
  def favours
    user.favours_for_me
  end
  
  def status(favour)
    status_generator.formepage_favour_status(favour)
  end
  
end