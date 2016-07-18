feature 'User accepts a bid that has been made on a favour' do
  before do
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
    sign_out
    sign_up(username: 'Testuser3', email:'testuser3@email.com')
    click_on 'Manage my clans'
    click_on 'Join 3 Greenway Road'
    click_on "Testuser3's dashboard"
    click_on 'Favours for others'
    fill_in('Number of thank you points', with: '10')
    click_on 'Bid'
    sign_out
    sign_in
    click_on "Testuser's dashboard"
    click_on 'Favours for me'
    within(:css, '.favours-benefiting-me li#bid_1') do
      click_on 'Accept bid'
    end
    sign_out
  end
  context 'and the favour has an accepted bid status' do
    scenario "which displays as 'your bid is accepted' in the forothersindex if it is the user's bid" do
      sign_in(email: 'testuser2@email.com', password: '123456')
      click_on 'Favours for others'
      expect(page).to have_css('.favours-i-bidded-on li p.status', text: 'Your bid is accepted and awaiting fulfilment')
    end
    scenario "which displays as 'your bid is rejected' in the forothersindex if it is another user's bid" do
      sign_in(email: 'testuser3@email.com', password: '123456')
      click_on 'Favours for others'
      expect(page).to have_css('.favours-i-bidded-on li p.status', text: 'Sorry, your bid was rejected')
    end
    scenario "which displays as 'a bid has been accepted for this favour' in the formeindex" do
      sign_in
      click_on 'Favours for me'
      expect(page).to have_css('.favours-benefiting-me li p.status', text: 'A bid has been accepted for this favour')
    end
  end
  scenario "and users cannot submit other bids on the favour" do
    sign_up(username: 'Testuser4', email:'testuser4@email.com')
    click_on 'Manage my clans'
    click_on 'Join 3 Greenway Road'
    click_on "Testuser4's dashboard"
    click_on 'Favours for others'
    expect(page).not_to display_favour_i_can_bid_on(text:'The washing up')
  end
  scenario "and users cannot accept other bids on the favour" do
    sign_in
    click_on "Testuser's dashboard"
    click_on 'Favours for me'
    expect(page).not_to have_content 'Accept bid'
  end
end