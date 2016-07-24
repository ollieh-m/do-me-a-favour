module FavoursHelper
  
  def users_array(current_user,others_benefiting)
    users_array = [current_user]
    unless others_benefiting.nil?
      others_benefiting.each{|user_id| users_array << User.find(user_id.to_i)}
    end
    users_array
  end
  
  def clans_array(clan_ids)
    clans_array = []
    unless clan_ids.nil?
      clan_ids.each_key{|clan_id| clans_array << Clan.find(clan_id.to_i)}
    end
    clans_array
  end
  
end