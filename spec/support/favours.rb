module Features
  
  def create_favour(user: 'Testuser', description: 'The washing up', clans: ['clan_1'], users_benefiting: nil)
    click_on "#{user}'s dashboard"
    click_on 'Favours for me'
    clans.each{|clan| check "#{clan}"}
    unless users_benefiting.nil?
      users_benefiting.each{|user_benefiting| select(user_benefiting, from: 'users_benefiting')}
    end
    fill_in('Next, describe the favour...', with: description)
    click_on 'Request help'
  end
  
  def confirm_favour_has_been_done(user:,bid_number:)
    within(:css, ".favours-benefiting-me li#bid_#{bid_number}") do
      click_on "#{user} has done this favour"
    end
  end
  
  def display_favour_i_can_bid_on(text)
    have_css('.favours-i-can-bid-on li', text: text)
  end
  
  def display_favour_i_bidded_on_status(text)
    have_css('.favours-i-bidded-on li div.status', text: text)
  end
  
  def display_favour_i_bidded_on(text)
    have_css('.favours-i-bidded-on li', text: text)
  end
  
  def display_favour_for_me_status(text)
    have_css('.favours-benefiting-me li div.status', text: text)
  end
  
end