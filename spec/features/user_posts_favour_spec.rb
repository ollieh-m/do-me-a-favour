feature 'User posts a favour just for themself' do
  before do
    sign_up
    create_clan(name: '3 Greenway Road', description: 'Home')
    visit root_path
    create_clan(name: '4 Emery Road', description: 'Office')
    create_favour(clans: ['clan_1','clan_2'])
  end
  scenario 'to two clans, members of which then see the favour in the favours they can bid on' do
    sign_out
    sign_up(username: 'Testuser2', email:'testuser2@email.com')
    join_clan
    click_on "Testuser2's dashboard"
    click_on 'Favours for others'
    
    expect(page).to display_favour_i_can_bid_on('The washing up')
  end
  
  scenario 'and they do not see the favour in their own list of favours they can bid on' do
    click_on "Testuser's dashboard"
    click_on 'Favours for others'
    
    expect(page).not_to display_favour_i_can_bid_on('The washing up')
  end
end

feature 'User posts a favour for themself and another user' do
  scenario 'so both can see it in the list of favours they can do for other people' do
    sign_up(username:'Testuser2',email:'testuser2@email.com')
    sign_out
    
    sign_up
    create_clan(name: '3 Greenway Road', description: 'Home')
    create_favour(users_benefiting: ['Testuser2'])
    click_on "Testuser's dashboard"
    click_on 'Favours for others'
    
    expect(page).to display_favour_i_can_bid_on('The washing up')
  end
end
  
feature 'User posts an invalid favour' do
  scenario 'with no description' do
    sign_up
    create_clan(name: '3 Greenway Road', description: 'Home')
    create_favour(description: '')
    expect(page).to have_content("Description can't be blank")
    
    sign_out
    sign_up(username: 'Testuser2', email:'testuser2@email.com')
    join_clan
    click_on "Testuser2's dashboard"
    click_on 'Favours for others'
    expect(page).not_to have_css('.favours li')
  end
  
  scenario 'with no clan specified' do
    sign_up
    create_clan(name: '3 Greenway Road', description: 'Home')
    click_on "Testuser's dashboard"
    click_on 'Favours for me'
    fill_in('Next, describe the favour...', with: 'The washing up')
    click_on 'Request help'
    expect(page).to have_content('You need to choose at least one clan')
    
    sign_out
    
    sign_up(username: 'Testuser2', email:'testuser2@email.com')
    join_clan
    click_on "Testuser2's dashboard"
    click_on 'Favours for others'
    expect(page).not_to display_favour_i_can_bid_on('The washing up')
  end
end