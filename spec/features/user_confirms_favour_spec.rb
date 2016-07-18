feature 'User confirms a favour has been carried out' do
  before do
    sign_up(username: 'Testuser2', email: 'testuser2@email.com')
    sign_out
    
    sign_up
    create_clan(name: '3 Greenway Road', description: 'Home')
    click_on "Testuser's dashboard"
    click_on 'Favours for me'
    check 'clan_1'
    select('Testuser2', from: 'users_benefiting')
    fill_in('Description', with: 'The washing up')
    click_on 'Request help'
    sign_out
    
    sign_up(username: 'Testuser3', email:'testuser3@email.com')
    click_on 'Manage my clans'
    click_on 'Join 3 Greenway Road'
    click_on "Testuser3's dashboard"
    click_on 'Favours for others'
    fill_in('Number of thank you points', with: '20')
    click_on 'Bid'
    sign_out
    
    sign_in
    click_on "Testuser's dashboard"
    click_on 'Favours for me'
    within(:css, '.favours-benefiting-me li#bid_1') do
      click_on 'Accept bid'
    end
    within(:css, '.favours-benefiting-me li#bid_1') do
      click_on 'Testuser3 has done this favour'
    end
    sign_out
  end
  
  scenario "and status appears as 'Nice one - you did this favour' if the user's bid had been accepted" do
    sign_in(email: 'testuser3@email.com', password: '123456')
    click_on 'Favours for others'
    expect(page).to have_css('.favours-i-bidded-on li p.status', text: 'Nice one - you did this favour')
  end
  scenario "and status appears as 'This favour has been carried out' if the favour benefited you" do
    sign_in
    click_on 'Favours for me'
    expect(page).to have_css('.favours-benefiting-me li p.status', text: 'This favour haas been carried out')
  end
  context "and Thank you points are exchanged" do
    scenario '- the user who made the accepted bid gains the specified thank you points' do
      sign_in(email: 'testuser3@email.com', password: '123456')
      expect(page).to have_content '120 Thank You Points'
    end
    scenario '- the users who benefited from the favour each lose their share of the specified thank you points' do
      sign_in
      expect(page).to have_content '90 Thank You Points'
      sign_out
      sign_in(email: 'testuser2@email.com', password: '123456')
      expect(page).to have_content '90 Thank You Points'
    end
  end
end