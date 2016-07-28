feature 'User accepts a bid that has been made on a favour' do
  before do
    sign_up
    create_clan(name: '3 Greenway Road', description: 'Home')
    create_favour
    sign_out
    
    sign_up(username: 'Testuser2', email:'testuser2@email.com')
    join_clan
    make_bid(user: 'Testuser2', points: 20)
    sign_out
    
    sign_up(username: 'Testuser3', email:'testuser3@email.com')
    join_clan
    make_bid(user: 'Testuser3', points: 10)
    sign_out
    
    sign_in
    accept_bid(bid_number: 1)
    sign_out
  end
  context 'and the favour has an accepted bid status' do
    scenario "which displays as 'your bid is accepted' in the forothersindex if it is the user's bid" do
      sign_in(email: 'testuser2@email.com', password: '123456')
      click_on 'Favours for others'
      expect(page).to display_favour_i_bidded_on_status('Your bid is accepted and awaiting fulfilment')
    end
    scenario "which displays as 'your bid is rejected' in the forothersindex if it is another user's bid" do
      sign_in(email: 'testuser3@email.com', password: '123456')
      click_on 'Favours for others'
      expect(page).to display_favour_i_bidded_on_status('Sorry, your bid was rejected')
    end
    scenario "which displays as 'a bid has been accepted for this favour' on the favoursforme page" do
      sign_in
      click_on 'Favours for me'
      expect(page).to display_favour_for_me_status('A bid has been accepted for this favour')
    end
  end
  scenario "and users cannot submit other bids on the favour" do
    sign_up(username: 'Testuser4', email:'testuser4@email.com')
    join_clan
    click_on "Testuser4's dashboard"
    click_on 'Favours for others'
    expect(page).not_to display_favour_i_can_bid_on('The washing up')
  end
  scenario "and users cannot accept other bids on the favour" do
    sign_in
    click_on "Testuser's dashboard"
    click_on 'Favours for me'
    expect(page).not_to have_button('Accept bid')
  end
end