feature 'User posts a favour just for themself' do
  scenario 'to two clans, members of which then see the favour in the favours they can bid on' do
    sign_up
    create_clan(name: '3 Greenway Road', description: 'Home')
    visit root_path
    create_clan(name: '4 Emery Road', description: 'Office')
    click_on "Testuser's dashboard"
    click_on 'Favours for me'
    check 'clan_1'
    check 'clan_2'
    fill_in('Description', with: 'The washing up')
    click_on 'Request help'
    sign_out
    sign_up(username: 'Testuser2', email:'testuser2@email.com')
    click_on 'Manage my clans'
    click_on 'Join 3 Greenway Road'
    click_on "Testuser2's dashboard"
    click_on 'Favours for others'
    expect(page).to have_css('.favours li', text: 'The washing up')
  end
  scenario 'and they do not see the favour in their own list of favours they can bid on' do
    
  end
end