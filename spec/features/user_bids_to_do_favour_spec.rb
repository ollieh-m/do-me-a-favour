feature 'User bids to do a favour' do
  before do
    sign_up
    create_clan(name: '3 Greenway Road', description: 'Home')
    click_on "Testuser's dashboard"
    click_on 'Favours for me'
    check 'clan_1'
    fill_in('Next, describe the favour...', with: 'The washing up')
    click_on 'Request help'
    sign_out
    sign_up(username: 'Testuser2', email:'testuser2@email.com')
    click_on 'Manage my clans'
    click_on 'Join 3 Greenway Road'
    click_on "Testuser2's dashboard"
    click_on 'Favours for others'
    fill_in('Number of thank you points', with: '20')
    click_on 'Bid'
  end
  scenario 'and the favour moves from favours I can bid on to favours I have already bidded on' do
    expect(page).to have_css('.favours-i-bidded-on li', text: 'The washing up')
  end
  context "and the favour has a 'bids pending' status" do
    scenario "displayed as 'bid awaiting response' in 'favours I have bidded for'" do 
      expect(page).to have_css('.favours-i-bidded-on li div.status', text: 'Awaiting response to your bid')
    end
    scenario "and 'bids waiting on your response' in favours for me'" do
      sign_out
      sign_in
      click_on 'Favours for me'
      expect(page).to have_css('.favours-benefiting-me li div.status', text: 'Bids in waiting on your response')
    end
  end
end