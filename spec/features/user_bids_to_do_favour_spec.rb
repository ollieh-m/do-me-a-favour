feature 'User bids to do a favour' do
  
  before do
    sign_up
    create_clan(name: '3 Greenway Road', description: 'Home')
    create_favour
    sign_out
    
    sign_up(username: 'Testuser2', email:'testuser2@email.com')
    join_clan
    make_bid(user: 'Testuser2', points: 20)
  end
  
  scenario 'and the favour moves from favours I can bid on to favours I have already bidded on' do
    expect(page).to display_favour_i_bidded_on('The washing up')
  end
  
  context "and the favour has a 'bids pending' status" do
    scenario "displayed as 'bid awaiting response' in 'favours I have bidded for'" do 
      expect(page).to display_favour_i_bidded_on_status('Awaiting response to your bid')
    end
    
    scenario "and 'bids waiting on your response' in favours for me'" do
      sign_out
      sign_in
      click_on 'Favours for me'
      expect(page).to display_favour_for_me_status('Bids in waiting on your response')
    end
  end
  
end