feature 'User bids to do a favour' do
  scenario 'and the favour moves from favours I can bid on to favours I have already bid on' do
    sign_up
    create_clan(name: '3 Greenway Road', description: 'Home')
    click_on "Testuser's dashboard"
    click_on 'Favours for me'
    check 'clan_1'
    fill_in('Description', with: 'The washing up')
    click_on 'Request help'
    sign_out
    sign_up(username: 'Testuser2', email:'testuser2@email.com')
    click_on 'Manage my clans'
    click_on 'Join 3 Greenway Road'
    click_on "Testuser2's dashboard"
    click_on 'Favours for others'
    fill_in('Number of thank you points', with: '20')
    click_on 'Bid'
    expect(page).to have_css('.favours-i-bidded-on li', text: 'The washing up')
  end
  scenario 'and the favour has a bid status of awaiting response in the favours I have bid on section' do
    
  end
  scenario "and the favour's status on the favours for me screen changes to bid received" do
    
  end
end