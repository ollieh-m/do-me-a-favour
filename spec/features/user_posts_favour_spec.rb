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
    click_on "Testuser's dashboard"
    click_on 'Favours for others'
    expect(page).not_to have_css('.favours li', text: 'The washing up')
  end
end

feature 'User posts a favour for themself and another user' do
  scenario 'so both can see it in the list of favours they can do for other people' do
    sign_up(username:'Testuser2',email:'testuser2@email.com')
    sign_out
    sign_up
    create_clan(name: '3 Greenway Road', description: 'Home')
    click_on "Testuser's dashboard"
    click_on 'Favours for me'
    check 'clan_1'
    fill_in('Description', with: 'The washing up')
    select('Testuser2', from: 'users_benefiting')
    click_on 'Request help'
    click_on "Testuser's dashboard"
    click_on 'Favours for others'
    expect(page).to have_css('.favours li', text: 'The washing up')
  end
end
  
feature 'User posts an invalid favour' do
  scenario 'with no description' do
    sign_up
    create_clan(name: '3 Greenway Road', description: 'Home')
    click_on "Testuser's dashboard"
    click_on 'Favours for me'
    check 'clan_1'
    fill_in('Description', with: '')
    click_on 'Request help'
    expect(page).to have_content("Description can't be blank")
    sign_out
    sign_up(username: 'Testuser2', email:'testuser2@email.com')
    click_on 'Manage my clans'
    click_on 'Join 3 Greenway Road'
    click_on "Testuser2's dashboard"
    click_on 'Favours for others'
    expect(page).not_to have_css('.favours li')
  end
  
  scenario 'with no clan specified' do
    sign_up
    create_clan(name: '3 Greenway Road', description: 'Home')
    click_on "Testuser's dashboard"
    click_on 'Favours for me'
    fill_in('Description', with: 'The washing up')
    click_on 'Request help'
    expect(page).to have_content('You need to choose at least one clan')
    sign_out
    sign_up(username: 'Testuser2', email:'testuser2@email.com')
    click_on 'Manage my clans'
    click_on 'Join 3 Greenway Road'
    click_on "Testuser2's dashboard"
    click_on 'Favours for others'
    expect(page).not_to have_css('.favours li', text: 'The washing up')
  end
end